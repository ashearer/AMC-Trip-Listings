// Email un-obfuscator for mailto: URLs
// By Andrew Shearer amc2005 (no spam) at shearersoftware dot (no spam) com

window.onload = function() {
    if (!document.getElementsByTagName) return;
    var a = document.getElementsByTagName('a');
    for (var i = 0; i < a.length; i++) {
        var href = a[i].getAttribute('href');
        if (href && href.substr(0, 7) == 'mailto:') {
            href = href.replace("REMOVE_123_THIS@ANTI_S.pam-", '@');
            a[i].setAttribute('href', href);
            while (a[i].firstChild) {
                a[i].removeChild(a[i].firstChild);
            }
            var child = document.createTextNode(href.substr(7));    // ditch 'mailto:' prefix
            a[i].appendChild(child);
        }
    }
}
