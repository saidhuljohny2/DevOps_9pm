import os
import smtplib
from google.cloud import storage

def send_email(sender_email, sender_password, receiver_email, subject, message):
    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as server:
        server.login(sender_email, sender_password)
        email_message = f"Subject: {subject}\n\n{message}"
        server.sendmail(sender_email, receiver_email, email_message)

def process_file(event, context):
    bucket_name = event['bucket']
    file_name = event['name']
    
    # Your Gmail account details
    sender_email = "your_sender@gmail.com"
    sender_password = "your_sender_password"
    receiver_email = "your_receiver@gmail.com"
    
    subject = "New File Created in Bucket"
    message = f"A new file '{file_name}' was created in bucket '{bucket_name}'."
    
    send_email(sender_email, sender_password, receiver_email, subject, message)

    print(f"Email sent for {file_name} in {bucket_name}")
