using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Repository
{
    public class UserAccountRepository : GenericRepository<UserAccount>, IUserAccountRepository
    {
        public UserAccountRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }

        public bool ChangePassword(string id, string oldPassword, string newPassword)
        {
            try
            {
                var user = dbSet.Where(x => x.UserId == id && x.IsDelete == false).FirstOrDefault();
                if (PasswordHashing.VerifyPassword(oldPassword, user.Password))
                {
                    user.Password = PasswordHashing.HashPassword(newPassword);
                    dbSet.Update(user);
                    dBContext.SaveChanges();
                    return true;
                }
                else
                {
                    throw new Exception("Old Password Not Correct!!!");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool CheckEmailExist(string email,string ggToken)
        {
            try
            {
                var user = dbSet.Where(x => x.Email == email || x.GoogleToken == ggToken).FirstOrDefault();
                return user != null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount CheckLoginByEmail(string email, string ggToken)
        {
            try
            {
                var user = dbSet.Where(x => x.Email == email && x.GoogleToken == ggToken && x.IsDelete == false).FirstOrDefault();
                return user;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount CheckLoginByUserName(string username, string password)
        {
            try
            {
                var user = dbSet.Where(x => x.Username == username && x.IsDelete == false).FirstOrDefault();
                if(user != null)
                {
                    var check = PasswordHashing.VerifyPassword(password, user.Password);
                    return check ? user : null;
                }
                return null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool CheckPhoneExist(string phone)
        {
            try
            {
                var user = dbSet.Where(x => x.PhoneNum == phone && x.IsDelete == false).FirstOrDefault();
                return user != null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool CheckUsernameExist(string username)
        {
            try
            {
                var user = dbSet.Where(x => x.Username == username && x.IsDelete == false).FirstOrDefault();
                return user != null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount GetUserInfo(string id)
        {
            try
            {
                var user = dbSet.Where(x => x.UserId == id && x.IsDelete == false).FirstOrDefault();
                return user;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount RegisWithEmail(string email, string ggToken, string fullname, string image)
        {
            try
            {
                UserAccount user = new UserAccount
                {
                    UserId = GenerateId.AutoGenerateId(),
                    Email = email,
                    GoogleToken = ggToken,
                    FullName = fullname,
                    AvatarName = image,
                    CreateDate = DateTime.Now,
                    UpdateDate = DateTime.Now,
                    Role = 1
                };
                dbSet.Add(user);
                dBContext.SaveChanges();
                return user;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount RegisWithUsername(string username, string password)
        {
            try
            {
                UserAccount user = new UserAccount
                {
                    UserId = GenerateId.AutoGenerateId(),
                    Username = username,
                    Password = PasswordHashing.HashPassword(password),
                    CreateDate = DateTime.Now,
                    UpdateDate = DateTime.Now,
                    Role = 1
                };
                dbSet.Add(user);
                dBContext.SaveChanges();
                return user;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public bool ChangeRole(string id, int role)
        {
            try
            {
                var user = dbSet.Where(x => x.UserId == id && x.IsDelete == false).FirstOrDefault();
                if (user != null)
                {
                    user.Role = role;
                    dbSet.Update(user);
                    dBContext.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
