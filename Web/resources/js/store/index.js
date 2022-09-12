import {createStore} from "vuex";

const store = createStore({
    state(){
        return {
            Cart:{
                items :[],
            }
        }
    },
    mutations : {
        CartAddToCart(state,item){
            state.Cart.items.push(item);
            localStorage.setItem('charssu_cart',JSON.stringify(state.Cart))
        },
        CartRemoveFromCart(state,index){
            state.Cart.items.splice(index,1);
            localStorage.setItem('charssu_cart',JSON.stringify(state.Cart))
        },
        CartSetEmpty(state){
            state.Cart.items=[];
            localStorage.removeItem('charssu_cart');
        },
        CartGetFromStorage(state){
            if (localStorage.getItem('charssu_cart')){
                state.Cart = JSON.parse(localStorage.getItem('charssu_cart'));
            }else {

            }
        }
    },
    getters : {
        CartItemCount: (state) => state.Cart.items.length,
        CartItemGet: (state) => state.Cart,
        CartTotalPrice : (state) => {
            let total=0;
            state.Cart.items.forEach(item => {
                if (item.product.sale !== null){
                    total+=parseInt(item.product.sale) * item.quantity;
                }else{
                    total+=parseInt(item.product.price) * item.quantity;
                }
            })
            return total;
        }
    }



});
export default store
