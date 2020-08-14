<template>
  <section>
      <h1>用户管理</h1>
      <div>
      <el-button @click="addUser">添加用户</el-button>
      <el-button @click="delUser">删除用户</el-button>
      </div>

       <el-table
      :data="tableData"
      style="width: 100%" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
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
        prop="role"
        label="角色">
          <template slot-scope="scope">
             <span v-for="(item,index) in scope.row.role" :key="index">
                {{item[1]}}
             </span>
        </template> 
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
      <el-table-column
        label="操作">
        <template slot-scope="scope">
            <el-button @click="handleUpdateUser(scope.row)">修改</el-button>
        </template>    
      </el-table-column>
    </el-table>
    <el-dialog
      :title="dialogTitle"
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
              account:'',
              password:'',
              user_name:'',
              phone:'',
              email:'',
              role:[]
            },
            dialogVisible:false,
            selectUser:[],
            dialogTitle:'添加用户'
        }
    },
    mounted(){
      this.loadData()
      this.loadRole()
      this.loadPermission()
    },
    methods:{
        delUser(){
          if(this.selectUser.length == 0){
                this.$message({
                    type: 'warning',
                    message: '请选择要删除的用户!'
                });
                return
            }
              this.$confirm('删除所选用户？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消'
            }).then(() => {
                let tempId = [];
                this.selectUser.forEach(item=>{
                    tempId.push(item.user_id)
                })
                let param = new URLSearchParams()
                param.append('ids',tempId.join(','))
                this.$axios.delete('/apis/user/deleteUser',{data: param}).then(res=>{
                    if(res.status === 200){
                        if(res.data.status === 0){
                            this.$message({
                                type:"success",
                                message:res.data.message
                            })
                            this.loadData()
                        }else{
                            this.$message({
                                type:"error",
                                message:res.data.message
                            })
                        }
                    }
                })
            }).catch(() => {
            });
        },
        handleSelectionChange(val){
            this.selectUser = val;
            console.log('this.selectUser++++++++++++++',this.selectUser);
        },
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
                  this.dialogVisible = false;
                  this.loadData()
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
        handleUpdateUser(row){
          this.dialogTitle = "修改用户信息"
          this.dialogVisible = true;
          this.UserForm.account = row.account;
          this.UserForm.password = row.password;
          this.UserForm.user_name = row.user_name;
          this.UserForm.email = row.email;
          this.UserForm.phone = row.phone;
          let temp = row.role;
          let name = []
          for (let i = 0; i < temp.length; i++) {
            name.push(temp[i][0])
          }
          this.UserForm.role = name;
        }
    }
}
</script>

<style>

</style>