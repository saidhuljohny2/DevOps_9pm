def generate_html():
    html_content = """
    <html>
    <head>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 0;
            }
            .container {
                background-color: #fff;
                border: 1px solid #ddd;
                padding: 20px;
                margin: 50px auto;
                width: 80%;
                text-align: center;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            }
            h1 {
                color: #333;
                font-size: 28px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>DevoSp with Johny</h1>
            <p>This is a beautiful webpage created with Python in a Google Cloud Function.</p>
        </div>
    </body>
    </html>
    """
    return html_content

def hello_world(request):
    html_content = generate_html()
    return html_content
