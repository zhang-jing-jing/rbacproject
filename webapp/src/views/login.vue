<template>
  <div class="login-page">
      <section class="login-box">
            <div class="title">欢迎登录</div>
            <el-form ref="form" :model="form" :rules="rules">
                <el-form-item  prop="username">
                    <el-input  prefix-icon="el-icon-user-solid" placeholder="请输入用户名" v-model="form.username"  @keyup.enter.native="login"></el-input>
                </el-form-item>
                <el-form-item  prop="password">
                    <el-input  prefix-icon="el-icon-lock" placeholder="请输入密码" type="password" v-model="form.password"  @keyup.enter.native="login"></el-input>
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
                    { min: 3, max: 64, message: '长度在 3 到 5 个字符', trigger: 'blur' }
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
                let param = new URLSearchParams()
                param.append('username', self.form.username)
                param.append('password', self.form.password)
                self.$axios.post('/apis/login',param).then(res=>{
                    if(res.status === 200){
                        if(res.data.status === 0){
                            this.$store.commit('saveUser',res.data.list)
                            this.$router.push({ path: '/manage' })
                        }else{
                            this.$message({
                                message: res.data.message,
                                type: 'warning'
                            });
                        }
                    }
                })
            } else {
                
                return false;
            }
            });
      },
    }

}
</script>

<style lang="scss">
.login-page{
    position: relative;
    width: 100%;
    height: 100%;
    min-height: 700px;
    background: url('../assets/bg.jpg');
    .login-box{
        background: #ffffff;
        width: 400px;
        position:absolute;
        top: 40%;
        left: 50%;
        margin-top: -200px;
        margin-left: -220px;
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