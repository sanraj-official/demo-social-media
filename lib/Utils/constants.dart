//To Validate Email
final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

//To extract raw text from HTML text
final RegExp htmlRegex = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

//To get popUp elements
enum PopUpOptions {  logOut ,profile, aboutUs}
