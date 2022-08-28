class Auth{

    AuthLoginUser(user,token){
        localStorage.setItem('charssu_auth_user',user)
        localStorage.setItem('charssu_auth_token',token)
    }

    AuthGetUser(){
        return JSON.parse(localStorage.getItem('charssu_auth_user'));
    }

    AuthGetToken(){
        return localStorage.getItem('charssu_auth_token')
    }

    AuthCheck(){
        return !!(this.AuthGetToken() && this.AuthGetUser());

    }

    AuthLogout(){
        localStorage.removeItem('charssu_auth_user');
        localStorage.removeItem('charssu_auth_token');
        Sweet.SweetToastMessage('از حساب کاربری خود خارج شده اید، در حال انتقال به صفحه ورود ...','info');
        setTimeout(() => {
            window.open('/management/auth','_self');
        }, 2000)

    }

}
export default Auth = new Auth();
