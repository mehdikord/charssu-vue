<template>
    <div class="page-title-area">
        <div class="d-table app-fade-in">
            <div class="d-table-cell">
                <div class="container">
                    <div class="page-title-content">
                        <h2>فروشگاه قطعات چارسو </h2>
                        <ul>
                            <li><a href="">صفحه اصلی</a></li>
                            <li>فروشگاه قطعات</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <section class="shop-area pt-5 pb-5">
        <div class="container">
            <h5 class="text-danger">دسته بندی محصولات</h5>
            <div class="woocommerce-topbar mt-3">
                <div class="row align-items-center">
                    <div v-for="(category,index) in categories" :key="index+'cat'" class="col-6 col-md-3 col-lg-2">
                        <div class="card-body text-center cat-box">
                            <div class="img-fluid">
                                <img src="/images/default/category.png" width="75" alt="">
                            </div>
                            <h6 class="mt-3">{{ category.name }}</h6>
                        </div>
                    </div>
                </div>
            </div>
            <hr class="mb-5">
        </div>
        <div class="container-fluid">
            <div class="row">
                <div v-if="products.len" class="col-12 text-center">
                    <img src="" width="350" alt="">
                    <h6 class="mt-5 mb-4 font-18">متاسفانه درحال حاضر هیچ محصولی در فروشگاه موجود نیست !</h6>
                </div>
                <template v-else>
                    <div v-for="product in products" class="col-lg-3 col-md-4 col-sm-6">
                        <div class="single-product-box">
                            <div class="product-image text-center" >
                                <router-link :to="{name:'front_shop_products_single',params : {code : product.code}}">
                                    <template v-if="product.images.length">
                                        <img :src="product.images[0].image" width="210" height="210" :alt="product.name">
                                    </template>
                                    <img v-else src="/images/default/product.png" width="210" height="210" :alt="product.name">

                                </router-link>

                                <span href="" class="add-to-cart-btn">
                                    افزودن به سبد خرید
                                    <i class="flaticon-shopping-cart"></i>
                                </span>
                            </div>
                            <div class="product-content">
                                <h6 class="font-18">
                                    <router-link :to="{name:'front_shop_products_single',params : {code : product.code}}">
                                        {{product.name}}
                                    </router-link>
                                </h6>
                                <h6 class="text-center mt-3 font-12 text-secondary">
                                    <template v-if="product.product_category_id !== null">
                                        {{product.category.name}}
                                    </template>
                                </h6>
                                <hr>
                                <div class="price">
                                    <template v-if="product.sale !== null">
                                        <span class="new font-20 text-success">{{ this.NumberFormatter(product.sale)}}</span>
                                        <span class="old text-danger">{{ this.NumberFormatter(product.price)}}</span> تومان
                                    </template>
                                    <template v-else>
                                        <span class="new font-22 text-success">{{ this.NumberFormatter(product.price)}}</span> تومان
                                    </template>


                                </div>

                            </div>
                        </div>
                    </div>
                </template>

                <div class="col-lg-12 col-md-12">

                </div>
            </div>
        </div>
    </section>



</template>

<script>
export default {
    name: "Front_Shop_Index",
    created() {
      this.GetCategories();
      this.GetProducts();
    },
    data(){
        return {
            categories : [],
            products : [],
        }
    },
    methods : {
        GetCategories(){
            axios.get('/api/helpers/shop/products/categories').then(res => {
                this.categories = res.data;
            }).catch(e => {
                return Sweet.SweetServerErrorMessage();
            })
        },
        GetProducts(){
            axios.get('/api/helpers/shop/products').then(res => {
                this.products = res.data;
            }).catch(e => {
                return Sweet.SweetServerErrorMessage();
            })
        }

    }

}
</script>

<style scoped>
.cat-box{
    border-radius: 7px;
}
.cat-box:hover{
   background-color: rgba(33, 148, 242, 0.12);
    cursor: pointer;
}

</style>
