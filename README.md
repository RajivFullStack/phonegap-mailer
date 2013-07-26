phonegap-mailer
===============

PhoneGap 3.0-compatible plugin for sending emails and attachments via a native interface.

Usage
-----

To add the plugin to your project, simply run the following command from your project directory:

    phonegap local plugin add https://github.com/imsweb/phonegap-mailer.git

Once the plugin is added, to use it in your application:

    <script type="text/javascript" src="mailer.js"></script>
    <script type="text/javascript">
    var mailer = cordova.require("cordova/plugin/Mailer");
    mailer.compose("Hello World", "This is a test.", "", function() {
        console.log('Success!');
    });
    </script>
