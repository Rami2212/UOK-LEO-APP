# Save the privacy policy content to a .md file

privacy_policy_content = """
# Privacy Policy

_Last updated: May 21, 2025_

Thank you for using **UOK-LEO-APP**, the official mobile application of the LEO Club of the University of Kelaniya. Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application.

---

## 📌 Information We Collect

We collect the following types of information:

### 1. **Personal Information**
When you register or update your account, we may collect:
- Full name
- Email address
- Phone number
- User role (Member, Director, Admin)
- Profile picture (optional)

### 2. **Authentication Data**
- Encrypted password (stored securely)
- JWT tokens (stored locally on your device)

### 3. **Project-Related Activity**
- Project date requests
- Submitted evaluations
- Project participation status

### 4. **Device & Usage Information**
- Device type and model
- Operating system version
- Log data (errors, crash reports)

---

## 🔐 How We Use Your Information

We use your information for the following purposes:

- To authenticate users securely using JWT.
- To display personalized content (projects, achievements).
- To manage project date bookings and approvals.
- To send notifications related to club events and updates.
- To improve application performance and fix bugs.

---

## 📤 Data Sharing & Disclosure

We **do not** sell or rent your personal information to third parties.

We may share your information:
- With authorized administrators within the LEO Club for management purposes.
- When required by law, regulation, or legal process.
- With service providers who support app infrastructure (e.g., hosting, database).

---

## 🔒 Data Security

We take data security seriously:
- User credentials are encrypted and protected using Spring Security.
- Authentication tokens are stored securely using `flutter_secure_storage`.
- Only authorized users can access role-specific content via Role-Based Access Control (RBAC).

---

## 🗑️ Data Retention & Deletion

- Your personal information is retained as long as your account is active.
- You can request data deletion by contacting us at **leo-club@uok.lk**.
- Admins can deactivate or delete accounts as needed.

---

## 📱 Third-Party Services

This app does not use third-party analytics or advertising tools.  
However, backend services like MySQL and Spring Boot APIs are self-hosted and secured.

---

## 👶 Children's Privacy

This app is intended for university students and is **not intended for children under 13**. We do not knowingly collect personal data from children.

---

## ⚙️ Changes to This Policy

We may update this Privacy Policy from time to time. Any changes will be posted in this file and reflected with the updated date at the top.

---

## 📧 Contact Us

If you have questions or concerns regarding this policy, please contact us:

📮 **leo-club@uok.lk**
"""

# Save the file
file_path = "/mnt/data/PRIVACY_POLICY.md"
with open(file_path, "w") as file:
file.write(privacy_policy_content)

file_path
