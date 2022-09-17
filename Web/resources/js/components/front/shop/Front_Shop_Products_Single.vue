<template>

    <section class="product-details-area ptb-100 mt-5">
        <template v-if="product !== null">
            <div class="container app-fade-in">
                <div class="row align-items-center">
                    <div class="col-lg-6 col-md-12">
                        <div class="product-details-image text-center">
                            <template v-if="product.images.length">
                                <img :src="product.images[0].image" :alt="product.name">
                            </template>
                            <img v-else src="/images/default/product.png" alt="image">
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12">
                        <div class="product-details-desc">
                            <h3>
                                {{product.name}}
                            </h3>
                            <div class="mt-3 mb-3">
                                <span class="text-secondary">دسته بندی : </span>
                                <span v-if="product.category_id !== null" class="text-danger">{{product.category.name}}</span>
                            </div>
                            <div class="mt-3 mb-3">
                                <span class="text-secondary">نام مدل : </span>
                                <span v-if="product.device_brand_id !== null" class="text-danger">{{product.brand.name}}</span>
                            </div>
                            <div class="mt-3 mb-3">
                                <span class="text-secondary">کد محصول : </span>
                                <span class="text-danger">{{product.code}}</span>
                            </div>
                            <div class="price">
                                <template v-if="product.sale !== null">
                                    <span class="font-20 text-success">{{ this.NumberFormatter(product.sale)}}</span>

                                    <span class="old-price ml-1">{{ this.NumberFormatter(product.price)}}</span>
                                    <span class="mr-2 font-12">تومان</span>

                                </template>
                                <template v-else>
                                    <span class="font-20 text-success">{{ this.NumberFormatter(product.price)}}</span>
                                    <span class="mr-2 font-12">تومان</span>
                                </template>

                            </div>
                            <div class="product-review">
                                <div class="rating font-16">
                                    <i class="mdi mdi-star"></i>
                                    <i class="mdi mdi-star"></i>
                                    <i class="mdi mdi-star"></i>
                                    <i class="mdi mdi-star"></i>
                                    <i class="mdi mdi-star"></i>
                                </div>
                            </div>
                            <div class="mt-2 mb-3">
                                با چارسو ، تضمین خرید با بهترین قیمت را تجربه کنید !
                            </div>
                            <div class="product-add-to-cart">
                                <div class="input-counter">
                                    <span v-if="quantity > 1" @click="quantity--"  class="minus-btn">
                                        <i class="mdi mdi-minus"></i>
                                    </span>
                                    <input type="number"  v-model="quantity">
                                    <span @click="quantity++" class="plus-btn">
                                        <i class="mdi mdi-plus"></i>
                                    </span>
                                </div>
                                <button @click="this.CartAddToCart({product : product, quantity : quantity})" type="button" class="default-btn">
                                    <i class="fas fa-cart-plus"></i>
                                    افزودن به سبد خرید
                                </button>
                            </div>
                            <div class="buy-checkbox-btn">

                            </div>
                            <div class="custom-payment-options">
                                <div class="payment-methods">

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12">
                        <div class="tab products-details-tab">
                            <div class="row">
                                <div class="col-lg-12 col-md-12">
                                    <ul class="tabs">
                                        <li class="bg-primary">
                                            <a class="text-light">
                                                <div class="dot"></div>
                                                توضیحات کامل
                                            </a>
                                        </li>

                                        <li>
                                            <a >
                                                <div class="dot"></div>
                                                نظرات کاربران
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-lg-12 col-md-12">
                                    <div class="tab_content">
                                        <div class="tabs_item">
                                            <div class="products-details-tab-content">
                                                <p class="text-justify">
                                                    {{product.description}}
                                                </p>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="related-products app-fade-in">
                <div class="container">
                    <div class="products-title">
                        <span class="sub-title">Our Shop</span>
                        <h5>محصولات مرتبط با {{product.name}}</h5>
                    </div>
                    <div class="row">

                    </div>
                </div>
            </div>
        </template>

    </section>


</template>

<script>
export default {
    name: "Front_Shop_Products_Single",
    created(){
      this.GetProduct();
    },
    data(){
        return {
            product:null,
            quantity : 1,
        }
    },
    methods:{
        GetProduct(){
            axios.get('/api/helpers/shop/products/single/' + this.$route.params.code).then(res =>{
                this.product = res.data
            }).catch(e => {
                return Sweet.SweetServerErrorMessage();
            })

        }
    }
}
</script>

<style scoped>

</style>
