using EasyUIDemo.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EasyUIDemo.MVC.Controllers
{
    public class UserController : Controller
    {
        //
        // GET: /User/
        public ActionResult User_List()
        {
            return View();
        }

        /// <summary>
        /// 获取用户的所有信息
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAllUserInfo()
        {
            int pageIndex = Request["page"] == null ? 1 : int.Parse(Request["page"]);
            int pageSize = Request["rows"] == null ? 10 : int.Parse(Request["rows"]);
            int total = 0;
            using (EasyUIDemoDBEntities db = new EasyUIDemoDBEntities())
            {
                var temp1 = from u in db.UserInfo
                            select new
            {
                ID = u.ID,
                Mail = u.Mail,
                Name = u.Name,
                Phone = u.Phone,
                Password = u.Password,
                Address = u.Address,
                CreateTime =u.CreateTime,
                Enable = u.Enable
            };
                total = temp1.Count();

                var users1 = temp1.ToList().Skip((pageIndex - 1) * pageSize).Take(pageSize);
                var data = new
                {
                    total = total,
                    rows = users1
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            
        }

        /// <summary>
        /// 添加用户
        /// </summary>
        /// <param name="userinfo"></param>
        /// <returns></returns>
        public ActionResult AddUser(UserInfo userinfo)
        {
            userinfo.CreateTime = DateTime.Now;
            using (EasyUIDemoDBEntities db = new EasyUIDemoDBEntities())
            {
                db.UserInfo.Add(userinfo); 
                db.SaveChanges();
            }
            return Content("OK");
        }

        /// <summary>
        /// 绑定用户数据
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public ActionResult GetBindDetails(int ID)
        {
            //using (EasyUIDemoDBEntities db = new EasyUIDemoDBEntities())
            //{
            EasyUIDemoDBEntities db = new EasyUIDemoDBEntities();
                var BindIDForUpdateTextBox = db.UserInfo.Where(u => u.ID == ID).ToList().FirstOrDefault() ;
                return Json(BindIDForUpdateTextBox, JsonRequestBehavior.AllowGet);
            //}
        }
        public ActionResult UpdateUser(UserInfo user)
        {

            try
            {
                EasyUIDemoDBEntities db = new EasyUIDemoDBEntities();
                //要更新的实体
                var upuser = db.UserInfo.Where(u => u.ID == user.ID).ToList().FirstOrDefault();
                upuser.Address = user.Address;
                upuser.Enable = user.Enable;
                upuser.Mail = user.Mail;
                upuser.Name = user.Name;
                upuser.Phone = user.Phone;
                upuser.Password = user.Password;
                db.SaveChanges();
                return Content("OK");
            }
            catch
            {
                return Content("Error");
            }
        }

        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="deleteUserInfoID"></param>
        /// <returns></returns>
        public ActionResult DeleteUser(string deleteUserInfoID, string Name)
        {
            var UIdsName = Name.Split(',');
            List<string> deleteUName = new List<string>();
            foreach (var item in UIdsName)
            {
                deleteUName.Add(item);
            }
            if (deleteUName.Contains(Session["UserName"].ToString()))
            {
                return Content("含有正在使用的用户，禁止删除");
            }

            if (string.IsNullOrEmpty(deleteUserInfoID))
            {
                return Content("请选择您要删除的数据");
            }
            var idsStr = deleteUserInfoID.Split(',');
            List<int> deleteIDList = new List<int>();
            foreach (var ID in idsStr)
            {
                deleteIDList.Add(Convert.ToInt32(ID));
            }
            using (EasyUIDemoDBEntities db = new EasyUIDemoDBEntities())
            {
                foreach (var ID in deleteIDList)
                {
                    var users = db.UserInfo.Where(p => p.ID == ID).FirstOrDefault();
                    db.UserInfo.Remove(users);                    
                }
                db.SaveChanges();
            }
            return Content("OK");
        }
    }
}
