<template>
  <div class="login-page">
      <section class="login-box">
            <div class="title">欢迎登录</div>
            <el-form ref="form" :model="form" :rules="rules">
                <el-form-item  prop="username">
                    <el-input  prefix-icon="el-icon-user-solid" placeholder="请输入用户名" v-model="form.username"></el-input>
                </el-form-item>
                <el-form-item  prop="password">
                    <el-input  prefix-icon="el-icon-lock" placeholder="请输入密码" type="password" v-model="form.password"></el-input>
                </el-form-item>
                 <el-form-item>
                    <el-button type="primary" class="login-btn" @click="login">登录</el-button>
                 </el-form-item>
            </el-form>
      </section>
  </div>
</template>

<script>
export default {
    name:'login',
    data(){
        return{
            form:{
                username:'',
                password:''
            },
            rules: {
                username: [
                    { required: true, message: '请输入用户名', trigger: 'blur' },
                    { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
                ],
                password: [
                    { required: true, message: '请输入密码', trigger: 'change' }
                ],
            }
        }
    },
    methods:{
        login() {
            let self = this;
            this.$refs['form'].validate((valid) => {
            if (valid) {
                // self.$axios.post('http://localhost:8000/login').then(res=>{
                //     console.log('res+++++++++++=',res)
                // })
                self.$axios.post('/apis/login').then(res=>{
                    console.log('res+++++++++++=',res)
                })
                // this.$router.push({ path: '/manage' })
            } else {
                console.log('error submit!!');
                return false;
            }
            });
      },
    }

}
</script>

<style lang="scss">
.login-page{
    .login-box{
        width: 400px;
        margin: 0 auto;
        padding: 40px 20px;
        .title{
            font-size: 20px;
            margin: 20px;
            text-align: center;
        }
        .login-btn{
            width: 100%;
        }
        box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
    }
}

</style>