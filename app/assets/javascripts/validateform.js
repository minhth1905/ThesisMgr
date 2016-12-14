var _validFileExtensionsExcel = ["xlsx","xls"]
function ValidateSingleInputExcel(oInput) {
    if (oInput.type == "file") {
        var sFileName = oInput.value;
         if (sFileName.length > 0) {
            var blnValid = false;
            for (var j = 0; j < _validFileExtensionsExcel.length; j++) {
                var sCurExtension = _validFileExtensionsExcel[j];
                if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
                    blnValid = true;
                    break;
                }
            }

            if (!blnValid) {
                alert(sFileName + " không hợp lệ, vui lòng nhập file có đuôi " + _validFileExtensionsExcel.join(", "));
                oInput.value = "";
                return false;
            }
        }
    }
    return true;
}
