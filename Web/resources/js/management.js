import { createApp } from "vue";
import './bootstrap';
import {router} from './routes/manage';
import moment from "moment-jalaali";

const App=createApp({});

//----------------------------------------------------------------------------------------------------------------------
//Global Helpers
//----------------------------------------------------------------------------------------------------------------------
import Sweet from "./helpers/Sweet";
import Auth from "./helpers/ManagementAuth";
import AppStorage from "./helpers/AppStorage";

window.Sweet = Sweet;
window.Auth = Auth;
window.AppStorage = AppStorage;

//----------------------------------------------------------------------------------------------------------------------
//Global Component Source
//----------------------------------------------------------------------------------------------------------------------
import Manage_Template_Topbar from "./components/management/template/Manage_Template_Topbar";
import Manage_Template_Menu from "./components/management/template/Manage_Template_Menu";
import Manage_Template_Main_Content from "./components/management/template/Manage_Template_Main_Content";
import Manage_Inc_Page_Title from "./components/management/includes/Manage_Inc_Page_Title";
import Manage_Inc_Validation_Error from "./components/management/includes/Manage_Inc_Validation_Error";
import Manage_Inc_Item_Loading from "./components/management/includes/Manage_Inc_Item_Loading";
import Manage_inc_NoData from "./components/management/includes/Manage_inc_NoData";
import DatePicker from 'vue3-persian-datetime-picker'

//----------------------------------------------------------------------------------------------------------------------
//Global Components
//----------------------------------------------------------------------------------------------------------------------
App.component('manage_template_top_bar',Manage_Template_Topbar);
App.component('manage_template_menu',Manage_Template_Menu);
App.component('manage_template_main_content',Manage_Template_Main_Content);
App.component('page_title',Manage_Inc_Page_Title);
App.component('validation_errors',Manage_Inc_Validation_Error);
App.component('item_loading',Manage_Inc_Item_Loading);
App.component('item_loading',Manage_Inc_Item_Loading);
App.component('nodata',Manage_inc_NoData);
App.component('date-picker',DatePicker)

//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
//Global Mixin Methods
//----------------------------------------------------------------------------------------------------------------------

App.mixin({

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
//----------------------------------------------------------------------------------------------------------------------

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
App.mount("#app");
