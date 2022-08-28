class AppStorage{

    AppStorageSetItem(key,item){
        localStorage.setItem(key,item)
    }
    AppStorageDelItem(key){
        localStorage.removeItem(key)
    }

    AppStorageGetItem(key){
      return localStorage.getItem(key);
    }

    AppStorageCheckItem(key){
        return !!this.AppStorageGetItem(key);
    }

}
export default AppStorage = new AppStorage();
