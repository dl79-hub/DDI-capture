# DDI-capture
📞 Teams Telephony Number Management with Azure Automation
This project automates the retrieval and management of Microsoft Teams telephony numbers using Azure Automation and Blob Storage. It ensures that all assigned numbers are tracked and provides a mechanism to reassign any lost numbers via PowerShell.

🚀 Features
Retrieves all Teams telephony numbers and their assigned UPNs.
Uses an Azure Runbook to automate data collection.
Saves output to Azure Blob Storage.
Includes an Excel file that generates PowerShell scripts to reassign lost numbers.
Minimal-permission Azure Automation Account for secure execution.

🛠️ Technologies Used
Azure Automation
Azure Blob Storage
PowerShell
Microsoft Teams PowerShell Module
Excel (for script generation)

📦 Setup Instructions
1. Create Azure Resources
Blob Storage Account: To store the output CSV and Excel Recovery file
Automation Account: With minimal permissions to run the PowerShell script.

2. Configure Automation Account
Import required PowerShell modules (e.g., Teams).
Create a Runbook and paste the provided script.
Assign a managed identity or service principal with the necessary Teams permissions.

3. Run the Automation
Schedule or manually trigger the Runbook.
Output will be saved to the configured Blob Storage container.

4. Use the Excel File
Open the Excel file included in the repo.
Load the CSV output.
Automatically generate PowerShell commands to reassign any unassigned numbers.

📁 Project Structure
📂 /scripts
   └── Get Numbers.ps1
📂 /excel
   └── Number Recovery.xlsx
📄 README.md

🤝 Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your improvements or fixes.

📄 License
This project is licensed under the MIT License.

👤 Author
Damian Lewis - https://www.linkedin.com/in/damian-lewis79/
