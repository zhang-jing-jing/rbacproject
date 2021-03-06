import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user:{},
    username:'',
    activeIndex:''
  },
  mutations: {
    saveUser(state,user){
      console.log('user+++++',user)
      state.user = user
      state.username = user.user_name
      console.log(state)
    },
    setActiveIndex(state,index){
      state.activeIndex = index
    }
  },
  actions: {},
  modules: {}
});
