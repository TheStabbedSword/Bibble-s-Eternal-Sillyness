import funkin.backend.utils.NdllUtil;
import funkin.backend.utils.DiscordUtil;

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

    public static function getUserFromDiscord():String
    {
        #if DISCORD_RPC
        return DiscordUtil.user.globalName;
        #else
        return "Player";
        #end
    }
}