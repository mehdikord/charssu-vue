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
            <div class="row">

                <div v-if="products.len" class="col-12 text-center">
                    <img src="" width="350" alt="">
                    <h6 class="mt-5 mb-4 font-18">متاسفانه درحال حاضر هیچ محصولی در فروشگاه موجود نیست !</h6>
                </div>
                <template v-else>
                    <div v-for="product in products" class="col-lg-4 col-md-6 col-sm-6">
                        <div class="single-product-box">
                            <div class="product-image text-center" >
                                <a href="">
                                    <img class="img-shop" alt="image">
                                </a>
                                <a href="" class="add-to-cart-btn">
                                    افزودن به سبد خرید
                                    <i class="flaticon-shopping-cart"></i>
                                </a>
                            </div>
                            <div class="product-content">
                                <h6>
                                    <a href="">
                                        {{product.name}}
                                    </a>
                                </h6>
                                <h6 class="text-center text-primary">

                                </h6>
                                <div class="price">

                                    <span class="new font-22 text-success">151515</span>
                                    <span class="old text-danger">101010</span> تومان

                                    <span class="new font-22 text-success">151515</span> تومان

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
