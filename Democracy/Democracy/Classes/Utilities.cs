using System.IO;
using System.Web;

namespace Democracy.Classes
{
    public class Utilities
    {
        public static void UploadPhoto(HttpPostedFileBase file)
        {
            //upload image
            string path = string.Empty;
            string pic = string.Empty;

            if (file != null)
            {
                pic = Path.GetFileName(file.FileName);
                path = Path.Combine(HttpContext.Current.Server.MapPath("~/Content/Photos"), pic);
                file.SaveAs(path);// save local
                using (MemoryStream ms = new MemoryStream())
                {
                    file.InputStream.CopyTo(ms);
                    byte[] array = ms.GetBuffer();
                }
            }
        }
    }
}