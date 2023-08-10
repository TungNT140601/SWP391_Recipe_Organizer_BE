using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Interface
{
    public interface IUserAccountRepository:IGeneralRepository<UserAccount>
    {
        UserAccount CheckLoginByUserName(string username, string password);
        UserAccount CheckLoginByEmail(string email, string ggToken);
        UserAccount RegisWithUsername(string username, string password);
        UserAccount RegisWithEmail(string email, string ggToken);
        UserAccount GetUserInfo(string id);
        bool ChangePassword(string id,string oldPassword, string newPassword);
        bool CheckEmailExist(string email);
        bool CheckUsernameExist(string username);
        bool CheckPhoneExist(string phone);

    }
}
