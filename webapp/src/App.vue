<template>
  <div id="app">
    <router-view/>   
  </div>
</template>

<script>

export default {
  name: "app",
  components: {
  },
  created(){
     //在页面加载时读取localStorage里的状态信息
    localStorage.getItem("state") && this.$store.replaceState(Object.assign(this.$store.state,JSON.parse(localStorage.getItem("state"))));
    
    //在页面刷新时将vuex里的信息保存到localStorage里
    window.addEventListener("beforeunload",()=>{
        localStorage.setItem("state",JSON.stringify(this.$store.state))
    })
  },
  mounted() {
  },
  methods: {
  }
};
</script>

<style>
html,body{
  margin: 0;
  padding: 0;
}
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin:0;
  padding: 0;
}
</style>
