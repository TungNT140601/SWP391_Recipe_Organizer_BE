using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
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
            return userAccountRepository.Add(item);
        }

        public bool ChangePassword(string id, string oldPassword, string newPassword)
        {
            return userAccountRepository.ChangePassword(id, oldPassword, newPassword);
        }

        public bool CheckEmailExist(string email)
        {
            return userAccountRepository.CheckEmailExist(email);
        }

        public UserAccount CheckLoginByEmail(string email, string ggToken)
        {
            var check = userAccountRepository.CheckEmailExist(email);
            if (check)
            {
                return userAccountRepository.CheckLoginByEmail(email, ggToken);
            }
            else
            {
                return userAccountRepository.RegisWithEmail(email, ggToken);
            }
        }

        public UserAccount CheckLoginByUserName(string username, string password)
        {
            return userAccountRepository.CheckLoginByUserName(username, password);
        }

        public bool CheckPhoneExist(string phone)
        {
            return userAccountRepository.CheckPhoneExist(phone);
        }

        public bool CheckUsernameExist(string username)
        {
            return userAccountRepository.CheckUsernameExist(username);
        }

        public UserAccount Get(string id)
        {
            return userAccountRepository.Get(id);
        }

        public IEnumerable<UserAccount> GetAll()
        {
            return userAccountRepository.GetAll(new System.Linq.Expressions.Expression<Func<UserAccount, object>>[] {
                x => x.Plans,
                x => x.Recipes,
                x => x.Reviews,
                x => x.FavoriteRecipes
            });
        }

        public UserAccount GetUserInfo(string id)
        {
            return userAccountRepository.GetUserInfo(id);
        }

        public UserAccount RegisWithEmail(string email, string ggToken)
        {
            return userAccountRepository.RegisWithEmail(email, ggToken);
        }

        public UserAccount RegisWithUsername(string username, string password)
        {
            return userAccountRepository.RegisWithUsername(username, password);
        }

        public bool Remove(UserAccount item)
        {
            return userAccountRepository.Remove(item);
        }

        public bool Update(UserAccount item)
        {
            return userAccountRepository.Update(item);
        }
    }
}
