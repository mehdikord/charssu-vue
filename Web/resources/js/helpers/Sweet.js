import Swal from "sweetalert2";
import 'sweetalert2/dist/sweetalert2.min.css';

class Sweet{

    SweetToastMessage(message,icon = 'success'){
        const Toast = Swal.mixin({

            toast: true,
            position: 'bottom',
            showConfirmButton: false,
            timer: 4000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        })

        Toast.fire({
            icon: icon,
            color:'black',
            text: message
        })
    }

    SweetServerErrorMessage(){
        this.SweetToastMessage('مشکلی در ارتباط با سرور وجود دارد !','error')
    }

    SweetAlertMessage(message,title='پیام سیستم' ,icon='info'){
        Swal.fire({
            icon: icon,
            title: title,
            text: message,
            confirmButtonText:'باشه',
        })
    }

    SweetAddItem(){
        this.SweetToastMessage('آیتم جدید باموفقیت ایجاد شد');
    }

    SweetEditItem(){
        this.SweetToastMessage('آیتم مورد نظر باموفقیت ویرایش شد');
    }

    SweetDeleteItem(){
        this.SweetToastMessage('آیتم مورد نظر باموفقیت حذف شد');
    }

    SweetFileTypeError(types){
        this.SweetToastMessage('فایل انتخابی باید از نوع : '+types+' باشد','error');
    }
}

export default Sweet = new Sweet();
