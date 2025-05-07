from flask import Flask, request, jsonify
from flask_cors import CORS
import logging

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

# Configure logging
logging.basicConfig(level=logging.DEBUG)

# Pre-defined questions and answers
qa_data = {
    "what is careaawas?": "Careआवास is a Nasha Mukti Kendra Management System for rehab centers and NGOs.",
    "how to ssign patient treatment to a patient": "Open the patient list in the doctor's tab, choose the patient, and assign treatment based on smartwatch health data along with a note.",
    "how to check patient vitals": "Go to the Patient Details section, and under 'Vitals' you will see real-time vitals fetched from the Careआवास smartwatch.",
    "how can any doc register to caraaawas": "Doctors can register via the Careआवास app by selecting 'Doctor Signup' and filling the registration form.",
    "how to update patient record?": "Go to the 'Patient Management' section, select the patient, and click on 'Update Record' to edit health status, medication, or treatment plan.",
    "how to check assigned patients?": "Navigate to 'My Patients' in the doctor's dashboard to see a list of patients assigned to you.",
    "how to generate patient report?": "In the patient's profile, click on 'Generate Report' to download or share the patient's health report.",
    "how to change my profile details?": "Go to 'My Profile' and click on 'Edit Profile' to update your information.",
    "how to reset my password?": "On the login page, click 'Forgot Password' and follow the instructions to reset your password.",
    "how can i remove a patient?": "Doctors cannot remove patients. Only the NGO/Admin can archive or remove patient records for privacy & compliance.",
    "what is smartwatch data in careaawas?": "Careआवास smartwatch collects patient's vitals like heart rate, blood pressure, step count, and sleep cycle in real-time and syncs to the system.",
    "how to contact ngo for patient record?": "Use the 'Contact NGO' option in the patient's profile or request access through the admin panel."
}

# Contact Information
contact_info = "📞 Careआवास Support: +91-9876543210 | ✉️ Email: support@careaawas.in"

# Help Information
help_info = (
    "You can ask me things like:\n"
    "• How to assign treatment to a patient\n"
    "• How to check patient vitals\n"
    "• how can any doc register to caraaawas\n"
    "• how to check assigned patients?\n"
    "• how can i remove a patient?\n"
    "• how to reset my password?\n"
)

@app.route("/chat", methods=["POST", "OPTIONS"])
def chat():
    try:
        # Log incoming request details
        app.logger.debug(f"Received request: {request.json}")

        data = request.json
        user_message = data.get("message", "").lower().strip()

        # Comprehensive response handling
        if user_message in ["hey", "hello", "hi"]:
            response = {
                "response": "Hello! I'm the Careआवास assistant. How can I help you today?",
                "questions": list(qa_data.keys())
            }
        elif "contact" in user_message:
            response = {
                "response": f"Here is Careआवास contact information:\n{contact_info}",
                "questions": list(qa_data.keys())
            }
        elif "help" in user_message:
            response = {
                "response": help_info,
                "questions": list(qa_data.keys())
            }
        elif user_message in qa_data:
            response = {
                "response": qa_data[user_message],
                "questions": list(qa_data.keys())
            }
        else:
            response = {
                "response": "Sorry, I didn't understand that. Here are some questions I can help you with:",
                "questions": list(qa_data.keys())
            }

        app.logger.debug(f"Sending response: {response}")
        return jsonify(response)

    except Exception as e:
        app.logger.error(f"Error processing message: {e}")
        return jsonify({
            "response": f"Server error: {str(e)}",
            "questions": list(qa_data.keys())
        }), 500

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5000, debug=True)