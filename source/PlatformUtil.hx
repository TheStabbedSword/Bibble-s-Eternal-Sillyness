import funkin.backend.utils.NdllUtil;

var sendFakeMsgBox = NdllUtil.getFunction("sendFakeMsgBox", "sendFakeMsgBox", 1);
var sendWindowsNotification = NdllUtil.getFunction("sendWindowsNotification", "sendWindowsNotification", 2);

class PlatformUtil
{
    public static function sendNotification(title:String, desc:String)
    {
        #if windows
        return sendWindowsNotification(title, desc);
        #end
    }

    public static function sendFakeError(desc:String)
    {
        #if windows
        return sendFakeMsgBox(desc);
        #end
    }
}