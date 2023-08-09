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
    public class UserAccountRepository : GeneralRepository<UserAccount>, IUserAccountRepository
    {
        public UserAccountRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }

        public bool ChangePassword(string id, string oldPassword, string newPassword)
        {
            try
            {
                var user = dbSet.Find(id);
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

        public bool CheckEmailExist(string email)
        {
            try
            {
                var user = dbSet.Where(x => x.Email == email).FirstOrDefault();
                return user != null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount CheckLoginByEmail(string email, string ggToken, string password)
        {
            try
            {
                var user = dbSet.Where(x => x.Email == email && x.GoogleToken == ggToken && PasswordHashing.VerifyPassword(password, x.Password)).FirstOrDefault();
                return user != null ? user : null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount CheckLoginByPhone(string phone, string password)
        {
            try
            {
                var user = dbSet.Where(x => x.PhoneNum == phone && PasswordHashing.VerifyPassword(password, x.Password)).FirstOrDefault();
                return user != null?user:null;
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
                var user = dbSet.Where(x => x.Username == username && PasswordHashing.VerifyPassword(password, x.Password)).FirstOrDefault();
                return user != null?user:null;
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
                var user = dbSet.Where(x => x.PhoneNum == phone).FirstOrDefault();
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
                var user = dbSet.Where(x => x.Username == username).FirstOrDefault();
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
                var user = dbSet.Find(id);
                return user != null ? user : null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool RegisWithEmail(string email, string ggToken)
        {
            try
            {
                UserAccount user = new UserAccount
                {
                    UserId = GenerateId.AutoGenerateId(),
                    Email = email,
                    GoogleToken = ggToken,
                    CreateDate = DateTime.Now,
                    UpdateDate = DateTime.Now
                };
                dbSet.Add(user);
                dBContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool RegisWithPhone(string phone, string password)
        {
            try
            {
                UserAccount user = new UserAccount
                {
                    UserId = GenerateId.AutoGenerateId(),
                    PhoneNum = phone,
                    Password = PasswordHashing.HashPassword(password),
                    CreateDate = DateTime.Now,
                    UpdateDate = DateTime.Now
                };
                dbSet.Add(user);
                dBContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool RegisWithUsername(string username, string password)
        {
            try
            {
                UserAccount user = new UserAccount
                {
                    UserId = GenerateId.AutoGenerateId(),
                    Username = username,
                    Password = PasswordHashing.HashPassword(password),
                    CreateDate = DateTime.Now,
                    UpdateDate = DateTime.Now
                };
                dbSet.Add(user);
                dBContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
