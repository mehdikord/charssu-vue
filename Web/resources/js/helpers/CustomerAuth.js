class Auth{

    AuthLoginUser(user,token){
        localStorage.setItem('charssu_customer_auth_user',user)
        localStorage.setItem('charssu_customer_auth_token',token)
    }

    AuthGetUser(){
        return JSON.parse(localStorage.getItem('charssu_customer_auth_user'));
    }

    AuthGetToken(){
        return localStorage.getItem('charssu_customer_auth_token')
    }

    AuthCheck(){
        return !!(this.AuthGetToken() && this.AuthGetUser());

    }

    AuthLogout(url=null){
        localStorage.removeItem('charssu_customer_auth_user');
        localStorage.removeItem('charssu_customer_auth_token');
        Sweet.SweetToastMessage('از حساب کاربری خود خارج شده اید، در حال انتقال به صفحه ورود ...','info');
        let redirect = "/management/auth";
        if (url === 'app'){
            let redirect = "/auth";
        }
        setTimeout(() => {
            window.open(redirect,'_self');
        }, 2000)

    }

}
export default Auth = new Auth();
