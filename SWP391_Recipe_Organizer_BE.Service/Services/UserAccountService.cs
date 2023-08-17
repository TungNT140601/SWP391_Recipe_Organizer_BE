using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Repo.Repository;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class UserAccountService : IUserAccountService
    {
        private readonly IUserAccountRepository userAccountRepository;
        public UserAccountService(IUserAccountRepository userAccountRepository)
        {
            this.userAccountRepository = userAccountRepository;
        }

        public bool Add(UserAccount item)
        {
            try
            {
                return userAccountRepository.Add(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool ChangePassword(string id, string oldPassword, string newPassword)
        {
            try
            {
                return userAccountRepository.ChangePassword(id, oldPassword, newPassword);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool ChangeRole(string id, string role)
        {
            try
            {
                if (role.ToLower().Trim() == "cooker")
                {
                    return userAccountRepository.ChangeRole(id, 2);
                }
                if (role.ToLower().Trim() == "guest")
                {
                    return userAccountRepository.ChangeRole(id, 1);
                }
                return false;
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
                return userAccountRepository.CheckEmailExist(email);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount CheckLoginByEmail(string email, string ggToken, string fullname, string image)
        {
            try
            {
                var check = userAccountRepository.CheckEmailExist(email);
                if (check)
                {
                    return userAccountRepository.CheckLoginByEmail(email, ggToken);
                }
                else
                {
                    return userAccountRepository.RegisWithEmail(email, ggToken, fullname, image);
                }
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
                return userAccountRepository.CheckLoginByUserName(username, password);
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
                return userAccountRepository.CheckPhoneExist(phone);
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
                return userAccountRepository.CheckUsernameExist(username);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public UserAccount Get(string id)
        {
            try
            {
                return userAccountRepository.Get(x => x.UserId == id && x.IsDelete == false);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<UserAccount> GetAll()
        {
            try
            {
                return userAccountRepository.GetAll(x => x.IsDelete == false,
                    new System.Linq.Expressions.Expression<Func<UserAccount, object>>[] {
                x => x.Plans,
                x => x.Recipes,
                x => x.Reviews,
                x => x.FavoriteRecipes
                });
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
                return userAccountRepository.GetUserInfo(id);
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
                return userAccountRepository.RegisWithEmail(email, ggToken, fullname, image);
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
                return userAccountRepository.RegisWithUsername(username, password);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool BanUser(string id)
        {
            try
            {
                var user = userAccountRepository.Get(x => x.UserId == id && x.IsDelete == false);
                if (user != null)
                {
                    user.IsDelete = true;
                    user.UpdateDate = DateTime.Now;
                    return userAccountRepository.Update(user);
                }
                else
                {
                    throw new Exception("Not Found User");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public bool UnBanUser(string id)
        {
            try
            {
                var user = userAccountRepository.Get(x => x.UserId == id && x.IsDelete == true);
                if (user != null)
                {
                    user.IsDelete = false;
                    user.UpdateDate = DateTime.Now;
                    return userAccountRepository.Update(user);
                }
                else
                {
                    throw new Exception("Not Found User");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Update(UserAccount item)
        {
            try
            {
                return userAccountRepository.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
