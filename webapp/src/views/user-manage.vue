<template>
  <section>
      <h1>用户管理</h1>
      <el-button @click="addUser">添加用户</el-button>
       <el-table
      :data="tableData"
      style="width: 100%">
      <el-table-column
        prop="account"
        label="账号">
      </el-table-column>
      <el-table-column
        prop="user_name"
        label="用户姓名">
      </el-table-column>
      <el-table-column
        prop="phone"
        label="手机">
      </el-table-column>
      <el-table-column
        prop="email"
        label="邮箱">
      </el-table-column>
       <el-table-column
        prop="login_count"
        label="登录次数">
      </el-table-column>
        <el-table-column
        prop="create_time"
        label="创建时间">
      </el-table-column>
        <el-table-column
        prop="last_login_time"
        label="上次登录时间">
      </el-table-column>
    </el-table>
    <el-dialog
      title="添加用户"
      :visible.sync="dialogVisible"
      width="700px">
        <el-form style="width:80%;margin:0 auto;" ref="UserForm" :model="UserForm" label-width="80px">
          <el-form-item label="账号">
            <el-input v-model="UserForm.account"></el-input>
          </el-form-item>
          <el-form-item label="密码">
            <el-input v-model="UserForm.password"></el-input>
          </el-form-item>
          <el-form-item label="用户名">
            <el-input v-model="UserForm.user_name"></el-input>
          </el-form-item>
          <el-form-item label="手机">
            <el-input v-model="UserForm.phone"></el-input>
          </el-form-item>
          <el-form-item label="邮箱">
            <el-input v-model="UserForm.email"></el-input>
          </el-form-item>
          <el-form-item label="角色">
            <el-checkbox-group v-model="UserForm.role">
              <template v-for="item in roleData">
                <el-checkbox :key="item.role_id" :label="item.role_id">{{item.role_name}}</el-checkbox>
              </template>
            </el-checkbox-group>
          </el-form-item>
        </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="confirmAddUser">确 定</el-button>
      </span>
    </el-dialog>
  </section>
</template>

<script>
export default {
    data(){
        return {
            tableData:[],
            roleData:[],
            permissionData:[],
            UserForm:{
              role:[],
              permission:[]
            },
            dialogVisible:false,
        }
    },
    mounted(){
      this.loadData()
      this.loadRole()
      this.loadPermission()
    },
    methods:{
        loadData(){
            // let param = new URLSearchParams()
            this.$axios.get('/apis/getUserList').then(res=>{
                if (res.status === 200) {
                    if(res.data.status === 0){
                        this.tableData = res.data.list
                    }else if(res.data.status === 600){
                       this.$router.push({path:'/'})
                    }else{
                       this.$message({
                          message: res.data.message,
                          type: "error"
                      })
                    }
                }

            })
        },
        loadRole(){
            this.$axios.get('/apis/getRoleList').then(res=>{
                if (res.status === 200) {
                    if(res.data.status === 0){
                        this.roleData = res.data.list
                    }else if(res.data.status === 600){
                       this.$router.push({path:'/'})
                    }else{
                      this.$message({
                          message: res.data.message,
                          type: "error"
                      })
                    }
                }

            })
        },
        loadPermission(){
          this.$axios.get('/apis/getPermissionList').then(res=>{
                if (res.status === 200) {
                    if(res.data.status === 0){
                        this.permissionData = res.data.list
                    }else if(res.data.status === 600){
                       this.$router.push({path:'/'})
                    }else{
                      this.$message({
                          message: res.data.message,
                          type: "error"
                      })
                    }
                }
            })
        },
        addUser(){
          this.dialogVisible = true;
        },
        confirmAddUser(){
          console.log(this.UserForm);
          let param = new URLSearchParams()
          param.append('account',this.UserForm.account)
          param.append('password',this.UserForm.password)
          param.append('user_name',this.UserForm.user_name)
          param.append('phone',this.UserForm.phone)
          param.append('email',this.UserForm.email)
          param.append('role',this.UserForm.role.join(','))
          this.$axios.post('/apis/user/addUser',param).then(res=>{
            console.log(res)
            if(res.status === 200){
              if(res.data.status === 0){
                  this.$message({
                      message: res.data.message,
                      type: "success"
                  })
              }else if(res.data.status === 600){
                  this.$router.push({path:'/'})
              }else{
                  this.$message({
                      message: res.data.message,
                      type: "error"
                  })
              }
            }
          })
        }
    }
}
</script>

<style>

</style>