import './bootstrap';

import { createApp } from "vue";
import {router} from './routes/app';
import store from './store'
const App=createApp({});


//----------------------------------------------------------------------------------------------------------------------
//Global Helpers
//----------------------------------------------------------------------------------------------------------------------
import Sweet from "./helpers/Sweet";
import Auth from "./helpers/CustomerAuth";
import AppStorage from "./helpers/AppStorage";

window.Sweet = Sweet;
window.Auth = Auth;
window.AppStorage = AppStorage;

//----------------------------------------------------------------------------------------------------------------------
//Global Component Source
//----------------------------------------------------------------------------------------------------------------------
import Front_Template_Main_Navbar from "./components/front/template/Front_Template_Main_Navbar";
import Front_Template_Main_Footer from "./components/front/template/Front_Template_Main_Footer";
import DatePicker from "vue3-persian-datetime-picker";
import Manage_Inc_Validation_Error from "./components/management/includes/Manage_Inc_Validation_Error";
import moment from "moment-jalaali";



//----------------------------------------------------------------------------------------------------------------------
//Global Components
//----------------------------------------------------------------------------------------------------------------------
App.component('front_template_main_navbar',Front_Template_Main_Navbar);
App.component('front_template_main_footer',Front_Template_Main_Footer);
App.component('date-picker',DatePicker);
App.component('validation_errors',Manage_Inc_Validation_Error);


//----------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------
//Global Mixin Methods
//----------------------------------------------------------------------------------------------------------------------

App.mixin({
    beforeCreate() {
        this.$store.commit('CartGetFromStorage');
    },
    methods:{

        ValidationErrors(errors={},field){
            return errors[field] && errors[field].length ? errors[field] : {};
        },

        CopyText(text){
            /* Copy the text inside the text field */
            navigator.clipboard.writeText(text);
            Sweet.SweetToastMessage('باموفقیت کپی شد');
        },

        NumberFormatter(number){
            return new Intl.NumberFormat().format(number);
        },

        GetFileExtension(file){
            let explode = file.split('.');
            return explode[explode.length - 1]
        },

        NumberToEn(number) {
            if (number !== null){
                let find = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
                let replace = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
                let replaceString = number;
                let regex;
                for (let i = 0; i < find.length; i++) {
                    regex = new RegExp(find[i], "g");
                    replaceString = replaceString.replace(regex, replace[i]);
                }
                return replaceString;
            }
            return number;
        },

        UserAuthCheck(){
            return Auth.AuthCheck();
        },

        UserAuthGet() {
            return Auth.AuthGetUser();
        },
        CartAddToCart(item){
            this.$store.commit('CartAddToCart',item)
            return Sweet.SweetToastMessage('محصول باموفقیت به سبد خرید اضافه شد')
        },
        CartRemoveFromCart(index){

            this.$store.commit('CartRemoveFromCart',index)
            return Sweet.SweetToastMessage('محصول از سبد خرید حذف شد')

        }


    }

})
//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
//Global Filters
//----------------------------------------------------------------------------------------------------------------------

//Global Filters
App.config.globalProperties.$filters = {
    date(value,format) {
        return moment(value).format(format='jYYYY/jM/jD')
    }
}
//Axios Config
axios.defaults.headers.common['Authorization'] =  Auth.AuthGetToken();
axios.interceptors.response.use(function (response) {
    // Any status code that lie within the range of 2xx cause this function to trigger
    // Do something with response data
    return response;
}, function (error) {

    if (error.response.status ===  401){
        Auth.AuthLogout()
        Sweet.SweetToastMessage('شما از حساب کاربریتان خارج شده اید، لطفا دوباره وارد شوید','','error');
        // return Promise.reject(error);

    }else{
        return Promise.reject(error);
    }
});






App.use(router);
App.use(store)
App.mount("#app");
