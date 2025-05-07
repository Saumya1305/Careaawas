// require('dotenv').config();
// console.log("JWT Secret:", process.env.JWT_SECRET); // Debugging

// const express = require('express');
// const mysql = require('mysql');
// const bodyParser = require('body-parser');
// const cors = require('cors');
// const nodemailer = require('nodemailer');
// const multer = require('multer');
// const path = require('path');
// const fs = require('fs');
// const jwt = require('jsonwebtoken');
// const bcrypt = require('bcrypt');

// const app = express();
// app.use(bodyParser.json());
// //app.use(cors({ origin: 'http://localhost:3000' })); // Set frontend origin
// //app.use(cors)
// // Replace both existing cors lines with this
// app.use(cors({
//     origin: '*', // Allow all origins temporarily for testing
//     methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
//     allowedHeaders: ['Content-Type', 'Authorization'],
//     credentials: true
// }));



require('dotenv').config();
console.log("JWT Secret:", process.env.JWT_SECRET); // Debugging

const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');
const nodemailer = require('nodemailer');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const axios = require('axios');//HERE

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
//HERE


//app.use(cors());
app.use(cors({
    origin: '*',  // Be cautious in production
    methods: ['GET', 'POST', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));


app.use((req, res, next) => {
    console.log(`Received ${req.method} request to ${req.path}`);
    console.log('Request Body:', req.body);
    next();
});
//HERE



// Database Connection
const db = mysql.createConnection({
    host: '172.21.81.6',
    user: 'root',
    password: 'muskansi85820',  // Use environment variable
    database: 'careaawas',
});

db.connect((err) => {
    if (err) {
        console.error('Database connection error:', err);
        return;
    }
    console.log('Connected to MySQL!');
});

function isValidGoogleDriveLink(url) {
    // Basic validation for Google Drive links
    return url && typeof url === 'string' &&
        (url.includes('drive.google.com') ||
            url.includes('docs.google.com'));
}


// Nodemailer Configuration
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: process.env.EMAIL_USER,  // Use environment variable
        pass: process.env.EMAIL_PASS,  // Use environment variable
    }
});

// File Upload Setup
const uploadDir = path.join(__dirname, 'uploads/ngo_licenses');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, uploadDir),
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
    }
});

const fileFilter = (req, file, cb) => {
    const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif', 'application/pdf'];
    allowedTypes.includes(file.mimetype) ? cb(null, true) : cb(new Error('Invalid file type'), false);
};

const upload = multer({ storage, fileFilter, limits: { fileSize: 5 * 1024 * 1024 } });

// Password Reset Routes
const router = express.Router();

router.post('/forgot-password', (req, res) => {
    const { email } = req.body;

    db.query('SELECT * FROM ngo WHERE email = ?', [email], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Email not registered' });

        const resetToken = jwt.sign({ email }, process.env.JWT_SECRET, { expiresIn: '1h' });

        db.query('UPDATE ngo SET reset_token = ? WHERE email = ?', [resetToken, email], (err) => {
            if (err) return res.status(500).json({ error: err.message });

            const resetLink = `http://172.19.132.216:3000/auth/reset-password/${resetToken}`;
            const mailOptions = {
                from: process.env.EMAIL_USER,
                to: email,
                subject: 'Password Reset Request',
                html: `<p>Click the link to reset your password:</p><a href="${resetLink}">${resetLink}</a>`
            };

            transporter.sendMail(mailOptions, (err) => {
                if (err) return res.status(500).json({ error: 'Email sending failed' });
                res.json({ message: 'Reset link sent to email' });
            });
        });
    });
});

router.post('/reset-password', (req, res) => {
    const { token, newPassword } = req.body;

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) return res.status(400).json({ error: 'Invalid or expired token' });

        const email = decoded.email;

        bcrypt.hash(newPassword, 10, (err, hashedPassword) => {
            if (err) return res.status(500).json({ error: 'Error hashing password' });

            db.query('UPDATE ngo SET password = ?, reset_token = NULL WHERE email = ?', [hashedPassword, email], (err) => {
                if (err) return res.status(500).json({ error: err.message });
                res.json({ message: 'Password updated successfully' });
            });
        });
    });
});

app.use('/auth', router);

// Test Route
app.get('/test', (req, res) => {
    console.log('Test route hit');
    res.json({ message: 'Test successful' });
});

// Admin API to get all pending NGO verifications
app.get('/admin/ngo/pending', (req, res) => {
    const query = 'SELECT * FROM ngo WHERE verification_status = "pending"';
    db.query(query, (err, results) => {
        if (err) {
            console.log('Error fetching pending NGOs:', err);
            return res.status(500).send('Failed to fetch pending NGOs.');
        }
        res.send(results);
    });
});

// Admin API to approve or reject an NGO
app.put('/admin/ngo/:ngo_id/verify', (req, res) => {
    const { ngo_id } = req.params;
    const { status } = req.body; // 'verified' or 'rejected'
    
    if (status !== 'verified' && status !== 'rejected') {
        return res.status(400).send('Invalid status. Must be "verified" or "rejected".');
    }
    
    // Log the request for debugging
    console.log(`Updating NGO ${ngo_id} status to ${status}`);
    
    const query = 'UPDATE ngo SET verification_status = ?, verification_date = NOW() WHERE ngo_id = ?';
    db.query(query, [status, ngo_id], (err, result) => {
        if (err) {
            console.log('Error updating NGO verification:', err);
            return res.status(500).send('Failed to update NGO verification status.');
        }
        
        // Check if any rows were affected
        if (result.affectedRows === 0) {
            console.log(`No NGO found with ID: ${ngo_id}`);
            return res.status(404).send(`No NGO found with ID: ${ngo_id}`);
        }
        
        console.log(`NGO ${ngo_id} updated to ${status} successfully`);
        res.send(`NGO ${status === 'verified' ? 'approved' : 'rejected'} successfully!`);
    });
});

// Admin login API
app.post('/admin/login', (req, res) => {
    const { email, password } = req.body;
    
    const query = 'SELECT * FROM admin WHERE email = ? AND password = ?';

    db.query(query, [email, password], (err, results) => {
        if (err) {
            console.log('Error during login:', err);
            return res.status(500).send('Login failed.');
        }

        if (results.length === 0) {
            return res.status(401).send('Invalid credentials.');
        }

        res.send({ 
            message: 'Login successful', 
            admin: results[0] 
        });
    });
});

// Get all NGOs with their verification status
app.get('/admin/ngos', (req, res) => {
    const query = 'SELECT * FROM ngo ORDER BY verification_status, ngo_id DESC';
    db.query(query, (err, results) => {
        if (err) {
            console.log('Error fetching NGOs:', err);
            return res.status(500).send('Failed to fetch NGOs.');
        }
        res.send(results);
    });
});

// Get NGO statistics
app.get('/admin/statistics', (req, res) => {
    const query = `
        SELECT 
            (SELECT COUNT(*) FROM ngo WHERE verification_status = 'pending') as pending_ngos,
            (SELECT COUNT(*) FROM ngo WHERE verification_status = 'verified') as verified_ngos,
            (SELECT COUNT(*) FROM ngo WHERE verification_status = 'rejected') as rejected_ngos,
            (SELECT COUNT(*) FROM doctor) as total_doctors,
            (SELECT COUNT(*) FROM patient) as total_patients
    `;
    
    db.query(query, (err, results) => {
        if (err) {
            console.log('Error fetching statistics:', err);
            return res.status(500).send('Failed to fetch statistics.');
        }
        res.send(results[0]);
    });
});

// Get verification history
app.get('/admin/verifications', (req, res) => {
    const query = `
        SELECT 
            ngo_id, 
            ngo_name, 
            email, 
            verification_status, 
            verification_date 
        FROM ngo 
        WHERE verification_status IN ('verified', 'rejected') 
        ORDER BY verification_date DESC 
        LIMIT 50
    `;
    
    db.query(query, (err, results) => {
        if (err) {
            console.log('Error fetching verification history:', err);
            return res.status(500).send('Failed to fetch verification history.');
        }
        res.send(results);
    });
});


// Then your existing doctors route
app.get('/doctors', (req, res) => {
    console.log('Doctors route hit');  // Add logging
    const query = 'SELECT doctor_id, name FROM doctor';
    db.query(query, (err, results) => {
        if (err) {
            console.log('Error fetching doctors:', err);
            return res.status(500).json({ error: 'Failed to retrieve doctors' });
        }
        console.log('Query results:', results);  // Add logging
        res.json(results);
    });
});

app.get('/check-doctors', (req, res) => {
    db.query('SELECT COUNT(*) as count FROM doctor', (err, results) => {
        if (err) {
            console.log('Error:', err);
            res.status(500).json({ error: err.message });
        } else {
            console.log('Results:', results);
            res.json(results);
        }
    });
});






// Assign therapy to a specific patient
app.post('/assign_therapy', (req, res) => {
    const { patient_id, treatmentDate, therapyType, activity, dosage, notes } = req.body;

    //if (!patient_id || !treatmentDate || !therapyType || !activity || notes === undefined) {

    if (!patient_id || !treatmentDate || !therapyType || !activity || !dosage || !notes) {
        return res.status(400).json({ message: "All fields are required" });
    }

    const sql = `INSERT INTO treatment (patient_id, treatmentDate, therapyType, activity, dosage, notes) 
                 VALUES (?, ?, ?, ?, ?, ?)`;

    db.query(sql, [patient_id, treatmentDate, therapyType, activity, dosage, notes], (err, result) => {
        if (err) {
            console.error("Error inserting therapy:", err);
            return res.status(500).json({ message: "Database error", error: err });
        }
        res.status(201).json({ message: "Therapy assigned successfully", treatmentId: result.insertId });
    });
});







app.get("/chat", async (req, res) => {
    try {
        const userQuery = req.query.query;
        if (!userQuery) {
            return res.status(400).json({ error: "Query parameter is required" });
        }

        // Forward request to FastAPI chatbot
        const response = await axios.get(CHATBOT_API_URL, {
            params: { query: userQuery }
        });

        res.json(response.data);
    } catch (error) {
        console.error("Error fetching chatbot response:", error);
        res.status(500).json({ error: "Internal server error" });
    }
});





// Mock Data Generation for Vitals (Simulating smartwatch data)
function generateVitalsData(patient_id) {
    const heart_rate = Math.floor(Math.random() * (100 - 60 + 1)) + 60;  // Heart rate between 60 and 100
    const oxygen_level = Math.floor(Math.random() * (100 - 90 + 1)) + 90; // Oxygen level between 90 and 100
    const steps = Math.floor(Math.random() * (20000 - 5000 + 1)) + 5000;  // Steps between 5000 and 20000
    const timestamp = new Date().toISOString().slice(0, 19).replace('T', ' ');  // Current timestamp

    return {
        patient_id: patient_id,
        heart_rate: heart_rate,
        oxygen_level: oxygen_level,
        steps: steps,
        timestamp: timestamp
    };
}

// Endpoint to Generate and Insert Mock Data
app.get('/api/generate_vitals/:patient_id', (req, res) => {
    const { patient_id } = req.params;
    const vitals = generateVitalsData(patient_id);

    // Insert the mock vitals data into the database
    const query = 'INSERT INTO vitals (patient_id, heart_rate, oxygen_level, timestamp, steps) VALUES (?, ?, ?, ?, ?)';
    const values = [vitals.patient_id, vitals.heart_rate, vitals.oxygen_level, vitals.timestamp, vitals.steps];

    db.query(query, values, (err, results) => {
        if (err) {
            console.error('Error inserting data:', err);
            return res.status(500).json({ message: 'Error inserting vitals data' });
        }

        // Send the generated data back as response
        res.status(200).json(vitals);
    });
});






// //new ngo signup
// app.post('/ngo', upload.single('license_proof'), (req, res) => {
//     console.log("\n--- New NGO Registration Request ---");
//     console.log("Request Body Raw:", req.body);
//     console.log("Request File:", req.file ? "File received" : "No file received");

//     // Print each field value with explicit checks
//     console.log("ngo_name:", req.body.ngo_name || "NULL");
//     console.log("email:", req.body.email || "NULL");
//     console.log("ph_no:", req.body.ph_no || "NULL");
//     console.log("password:", req.body.password ? "PROVIDED" : "NULL");

//     // Check for missing fields
//     const missingFields = [];
//     if (!req.body.ngo_name) missingFields.push("ngo_name");
//     if (!req.body.email) missingFields.push("email");
//     if (!req.body.ph_no) missingFields.push("ph_no");
//     if (!req.body.password) missingFields.push("password");

//     if (missingFields.length > 0) {
//         console.log("Missing fields:", missingFields.join(", "));
//         return res.status(400).json({ 
//             error: `Missing required fields: ${missingFields.join(", ")}` 
//         });
//     }

//     // Check if file was uploaded
//     if (!req.file) {
//         console.log("Error: No license proof file uploaded");
//         return res.status(400).json({ error: "License proof file is required." });
//     }

//     const { ngo_name, email, ph_no, password } = req.body;
//     const license_proof_path = req.file.path.replace(/\\/g, '/');

//     console.log("Processing registration with:");
//     console.log("- NGO Name:", ngo_name);
//     console.log("- Email:", email);
//     console.log("- Phone:", ph_no);
//     console.log("- License Path:", license_proof_path);

//     // Insert into database with explicit values
//     const query = 'INSERT INTO ngo (ngo_name, email, ph_no, password, license_proof_path, verification_status, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())';
//     db.query(query, [ngo_name, email, ph_no, password, license_proof_path, 'pending'], (err, result) => {
//         if (err) {
//             console.log('Database Error:', err);
//             return res.status(500).json({ error: `Database error: ${err.message}` });
//         }

//         console.log("Registration successful! NGO ID:", result.insertId);
//         res.status(200).json({ 
//             message: 'NGO registered successfully!',
//             ngo_id: result.insertId,
//             status: 'Your account is pending verification.'
//         });
//     });
// });



app.post('/ngo', (req, res) => {
    const { ngo_name, email, ph_no, password, license_proof_url } = req.body;

    // Validate Google Drive link
    if (!license_proof_url || !isValidGoogleDriveLink(license_proof_url)) {
        return res.status(400).send('Valid Google Drive link for license proof document is required.');
    }

    // First, check if the NGO with this email already exists
    const checkQuery = 'SELECT * FROM ngo WHERE email = ?';
    db.query(checkQuery, [email], (checkErr, checkResults) => {
        if (checkErr) {
            console.log('Error checking NGO:', checkErr);
            return res.status(500).send('Failed to register NGO.');
        }

        if (checkResults.length > 0) {
            return res.status(409).send('An NGO with this email already exists.');
        }

        // If email is unique, proceed with insertion
        const query = 'INSERT INTO ngo (ngo_name, email, ph_no, password, license_proof_url, verification_status) VALUES (?, ?, ?, ?, ?, ?)';
        db.query(query, [ngo_name, email, ph_no, password, license_proof_url, 'pending'], (err, result) => {
            if (err) {
                console.log('Error saving NGO:', err);
                return res.status(500).send('Failed to register NGO.');
            }
            res.send({
                message: 'NGO registered successfully!',
                ngo_id: result.insertId,
                status: 'Your account is pending verification. We will review your documents shortly.'
            });
        });
    });
});





// API to get patients
app.get('/patients', (req, res) => {
    const query = 'SELECT * FROM patient';
    db.query(query, (err, results) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        res.json(results);
    });
});

// API to get doctors
app.get('/doctors', (req, res) => {
    const query = 'SELECT * FROM doctor';
    db.query(query, (err, results) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        res.json(results);
    });
});

//fetch doctor
app.get('/ngo/:ngoId/doctor', (req, res) => {
    const ngoId = parseInt(req.params.ngoId);
    // Get the NGO ID from the URL
    const query = 'SELECT * FROM doctor WHERE ngo_id = ?'; // Replace with your actual query logic
    db.query(query, [ngoId], (error, results) => {
        if (error) {
            return res.status(500).json({ message: 'Error fetching doctors', error });
        }
        res.json({ totalDoctors: results.length, doctors: results }); // ✅ Ensure doctors is an array
    });
});

app.get('/ngo/:ngoId/patient', (req, res) => {
    const ngoId = parseInt(req.params.ngoId);

    const query = `
        SELECT patient.* 
        FROM patient 
        INNER JOIN doctor ON patient.doctor_id = doctor.doctor_id
        WHERE doctor.ngo_id = ?;
    `;

    db.query(query, [ngoId], (error, results) => {
        if (error) {
            return res.status(500).json({ message: 'Error fetching patients', error });
        }
        res.json({ totalPatients: results.length, patients: results });
    });
});


// NGO login with email and password
// app.post('/ngo/login', (req, res) => {
//     const { email, password } = req.body; // Using email and password for login
//     const query = 'SELECT * FROM ngo WHERE email = ? AND password = ?';
//     db.query(query, [email, password], (err, results) => {
//         if (err) {
//             console.log('Error during login:', err);
//             return res.status(500).send('Login failed.');
//         }
//         if (results.length === 0) {
//             return res.status(401).send('Invalid credentials.');
//         }
//         res.send({ message: 'Login successful', ngo: results[0] });
//     });
// });
app.post('/ngo/login', (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required' });
    }

    // 🔹 **Step 1: Fetch NGO Data (Including verification_status)**
    const query = 'SELECT ngo_id, email, password, verification_status FROM ngo WHERE email = ? AND password = ?';

    db.query(query, [email, password], (err, results) => {
        if (err) {
            console.error('Database Error:', err);
            return res.status(500).json({ message: 'Internal server error' });
        }

        if (results.length === 0) {
            return res.status(401).json({ message: 'Invalid email or password' });
        }

        const ngo = results[0];

        // ❌ **Check Verification Status**
        if (ngo.verification_status === 'pending') {
            return res.status(403).json({ message: 'Your verification is pending. Please wait for approval.' });
        }
        if (ngo.verification_status === 'rejected') {
            return res.status(403).json({ message: 'Your NGO registration has been rejected. Contact support.' });
        }

        // ✅ **Successful login**
        res.status(200).json({
            message: 'Login successful',
            ngo: {
                ngo_id: ngo.ngo_id,
                email: ngo.email,
                verification_status: ngo.verification_status
            }
        });
    });
});


// Add doctor (from NGO)
app.post('/doctor', (req, res) => {
    const { name, license, email, mobile, degree, password, ngo_id } = req.body;
    const query = 'INSERT INTO doctor (name, license, email, mobile, degree, password, ngo_id) VALUES (?, ?, ?, ?, ?, ?,?)';
    db.query(query, [name, license, email, mobile, degree, password, ngo_id], (err, result) => {
        if (err) {
            console.log('Error adding doctor:', err);
            return res.status(500).send('Failed to add doctor: ');
        }
        res.send({ message: 'Doctor added successfully!', doctor_id: result.insertId });
    });
});


// Doctor login with email and password
app.post('/doctor/login', (req, res) => {
    const { email, password } = req.body;  // Using email and password for login
    const query = 'SELECT * FROM doctor WHERE email = ? AND password = ?';
    db.query(query, [email, password], (err, results) => {
        if (err) {
            console.log('Error during login:', err);
            return res.status(500).send('Login failed.');
        }
        if (results.length === 0) {
            return res.status(401).send('Invalid credentials.');
        }
        // Send doctor_id in the response
        res.send({ message: 'Login successful', doctor: results[0], doctor_id: results[0].id });
    });
});

app.get('/test', (req, res) => {
    res.send('Test route is working');
});




// Add patient (from NGO)
app.post('/patient', (req, res) => {
    const { name, age, mobile, email, addiction_type, password, doctor_id } = req.body;
    const query = 'INSERT INTO patient (name, age, mobile, email, addiction_type, password, doctor_id) VALUES (?, ?, ?, ?, ?, ?, ?)';
    db.query(query, [name, age, mobile, email, addiction_type, password, doctor_id], (err, result) => {
        if (err) {
            console.log('Error adding patient:', err);
            return res.status(500).send('Failed to add patient.');
        }
        res.send({ message: 'Patient added successfully!', patient_id: result.insertId });
    });
});

// Patient login with email and password
app.post('/patient/login', (req, res) => {
    const { email, password } = req.body;  // Using email and password for login
    const query = 'SELECT * FROM patient WHERE email = ? AND password = ?';
    db.query(query, [email, password], (err, results) => {
        if (err) {
            console.log('Error during login:', err);
            return res.status(500).send('Login failed.');
        }
        if (results.length === 0) {
            return res.status(401).send('Invalid credentials.');
        }
        res.send({ message: 'Login successful', patient: results[0] });
    });
});

// // Get patients assigned to a doctor
// app.get('/doctor/:doctorId/patients', (req, res) => {
//     const doctorId = req.params.doctorId;
//     const query = `
//         SELECT p.* FROM patient p
//         JOIN patient_doctor pd ON p.id = pd.patient_id
//         WHERE pd.doctor_id = ?`;
//     db.query(query, [doctorId], (err, results) => {
//         if (err) {
//             console.log('Error fetching patients:', err);
//             return res.status(500).send('Failed to fetch patients.');
//         }
//         res.send(results);
//     });
// });

//fetch new doctor patients
app.get('/doctor/patients/:doctor_id', (req, res) => {
    const doctorId = req.params.doctor_id;

    const query = 'SELECT * FROM patient WHERE doctor_id = ?';

    db.query(query, [doctorId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Database query error', details: err });
        }
        res.json(results);
    });
});

// Donation Signup Endpoint
app.post('/donate_users', (req, res) => {
    console.log('POST /donate_users hit'); // Debugging Log

    const { user_type, full_name, email, password, phone, address } = req.body;

    if (!user_type || !full_name || !email || !password || !phone || !address) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    const query = 'INSERT INTO donate_users (user_type, full_name, email, password, phone, address) VALUES (?, ?, ?, ?, ?, ?)';
    db.query(query, [user_type, full_name, email, password, phone, address], (err, result) => {
        if (err) {
            console.error('Error adding user:', err);
            return res.status(500).send('Failed to register donation user.');
        }
        res.status(201).json({ message: 'Donation user registered successfully!', user_id: result.insertId });
    });
});



// Login endpoint for donation
// Donate User login with email and password
app.post('/donate_users/login', (req, res) => {
    const { email, password } = req.body; // Get email and password from the body
    const query = 'SELECT * FROM donate_users WHERE email = ? AND password = ?';

    db.query(query, [email, password], (err, results) => {
        if (err) {
            console.log('Error during login:', err);
            return res.status(500).send('Login failed.');
        }
        if (results.length === 0) {
            return res.status(401).send('Invalid credentials.');
        }
        res.send({ message: 'Login successful', donate_user: results[0] });
    });
});


// Update patient's doctor
app.put('/patient/:id', (req, res) => {
    const { id } = req.params;
    const { doctor_id } = req.body;
    const query = 'UPDATE patient SET doctor_id = ? WHERE id = ?';
    db.query(query, [doctor_id, id], (err) => {
        if (err) {
            console.log('Error updating patient:', err);
            return res.status(500).send('Failed to update patient.');
        }
        res.send('Patient updated successfully!');
    });
});


//fetch doctor using ngo id
app.get('/api/doctors/:ngo_id', (req, res) => {
    const ngoId = req.params.ngo_id;
    const query = `SELECT doctor_id, name, license, mobile FROM doctor WHERE ngo_id = ?`;

    db.query(query, [ngoId], (error, results) => {
        if (error) {
            return res.status(500).json({ message: 'Error fetching doctors', error });
        }
        res.json({ totalDoctors: results.length, doctors: results });
    });
});




//total active patient (ngo)
app.get('/api/active-patients', (req, res) => {
    const { ngo_id } = req.query;

    if (!ngo_id) return res.status(400).json({ error: "ngo_id is required" });

    const query = `
      SELECT p.name, p.age, p.status 
      FROM patient p
      JOIN doctor d ON p.doctor_id = d.doctor_id
      WHERE d.ngo_id = ? AND p.status = 'under_treatment'
    `;

    db.query(query, [ngo_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});






app.post('/ask', async (req, res) => {
    try {
        const userMessage = req.body.message;
        const response = await axios.post('http://localhost:5000/chat', {
            message: userMessage,
        });
        res.json(response.data);
    } catch (error) {
        res.status(500).json({ error: 'Error communicating with Flask server' });
    }
});





app.get('/doctor/:doctor_id', (req, res) => {
    const { doctor_id } = req.params;

    const query = `
        SELECT d.name, d.license, d.email, d.mobile, d.degree, d.password, d.doctor_id, d.ngo_id, n.ngo_name 
        FROM doctor d
        LEFT JOIN ngo n ON d.ngo_id = n.ngo_id
        WHERE d.doctor_id = ?`;

    db.query(query, [doctor_id], (err, result) => {
        if (err) {
            return res.status(500).json({ error: 'Database error' });
        }
        if (result.length === 0) {
            return res.status(404).json({ error: 'Doctor not found' });
        }
        res.json(result[0]);
    });
});




// Update doctor details (only mobile, email, and degree)
app.put('/doctor/update/:doctor_id', (req, res) => {
    const { doctor_id } = req.params;
    const { email, mobile, degree } = req.body;

    const query = 'UPDATE doctor SET email = ?, mobile = ?, degree = ? WHERE doctor_id = ?';
    db.query(query, [email, mobile, degree, doctor_id], (err, result) => {
        if (err) {
            return res.status(500).json({ error: 'Database error' });
        }
        res.json({ message: 'Doctor details updated successfully' });
    });
});






// At the bottom of your index.js file, change your app.listen() to:
const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
    console.log(`Access from other devices at http://localhost:${PORT}`);
});