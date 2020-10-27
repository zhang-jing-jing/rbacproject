<template>
  <section>
      <h1>用户管理</h1>
      <el-row>
        <el-col :span="18">
          <el-button size="small" v-if="permission.indexOf('6') > -1" type="primary" @click="addUser">添加用户</el-button>
          <el-button size="small" v-if="permission.indexOf('4') > -1" type="primary" @click="delUser">删除用户</el-button>
        </el-col>
        <el-col :span="6">
              <el-input size="small" placeholder="请输入内容" v-model.trim="queryContent" class="input-with-select">
                <el-select v-model="querySelect" style="width:100px" slot="prepend" placeholder="请选择">
                  <template v-for="item in queryOption">
                    <el-option :key="item.value" :label="item.label" :value="item.value"></el-option>
                  </template>  
                </el-select>
                <el-button slot="append" icon="el-icon-search" @click="handleFilterUser"></el-button>
              </el-input>
        </el-col>
      </el-row>

       <el-table v-if="permission.indexOf('3') > -1"
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
        prop="permission" width="200px"
        label="权限">
          <template slot-scope="scope">
             <span v-for="(item,index) in scope.row.permission" :key="index">
                {{item[1]}},
             </span>
        </template> 
      </el-table-column>
       <el-table-column
        prop="login_count"
        label="登录次数">
      </el-table-column>
        <!-- <el-table-column
        prop="create_time"
        label="创建时间">
      </el-table-column> -->
        <el-table-column
        prop="last_login_time"
        label="上次登录时间">
      </el-table-column>
      <el-table-column
        label="操作">
        <template slot-scope="scope">
            <el-button v-if="permission.indexOf('5') > -1" @click="handleUpdateUser(scope.row)">修改</el-button>
        </template>    
      </el-table-column>
    </el-table>
    <div>
        <el-pagination style="text-align: right;"
          :current-page="currentPage"
          :page-size="pageSize"
          :page-sizes="[10, 20, 30]"
          layout="sizes, prev, pager, next"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange">
        </el-pagination>
    </div>
    <el-dialog
      :title="dialogTitle"
      :visible.sync="dialogVisible"
      width="700px">
        <el-form :rules="rules" style="width:80%;margin:0 auto;" ref="UserForm" :model="UserForm" label-width="80px">
          <el-form-item label="账号" prop="account">
            <el-input v-model="UserForm.account"></el-input>
          </el-form-item>
          <el-form-item v-if="dialogTitle=='添加用户'" label="默认密码" prop="password">
            <el-input v-model="UserForm.password"></el-input>
          </el-form-item>
          <el-form-item label="用户名" prop="user_name">
            <el-input v-model="UserForm.user_name"></el-input>
          </el-form-item>
          <el-form-item label="手机" prop="phone">
            <el-input v-model="UserForm.phone"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <el-input v-model="UserForm.email"></el-input>
          </el-form-item>
          <el-form-item label="角色" prop="role">
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
            dialogTitle:'添加用户',
            rules:{
                account: [
                    { required: true, message: '请输入账号', trigger: 'blur' },
                    { min: 1, max: 10, message: '长度在1到10个字符', trigger: 'blur' }
                ],
                password: [
                    { required: true, message: '请输入密码', trigger: 'change' },
                    {pattern: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,16}$/,message: '至少8-16个字符，至少1个大写字母，1个小写字母和1个数字', trigger: 'blur'}
                ],
                user_name: [
                    { required: false, message: '请输入用户名', trigger: 'change' }
                ],
                phone:[
                  { required: false, message: '请输入手机号', trigger: 'change' },
                  {pattern:/^1[3456789]\d{9}$/,message: '手机号输入有误，请重新输入', trigger: 'blur'}
                ],
                email:[
                  { required: false, message: '请输入邮箱', trigger: 'change' },
                  {pattern: /[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?/,message: '请輸入正确的格式', trigger: 'blur'}
                ],
                role:[
                  { required: true, message: '请选择角色', trigger: 'change' }
                ]
            },
            permission:'',
            total:0,
            pageSize:10,
            currentPage:1,
            queryContent:'',
            querySelect:'',
            queryOption:[
              {label:'角色',value:'role'},
              {label:'账号',value:'account'},
              {label:'用户名',value:'user_name'},
              {label:'电话',value:'phone'},
              {label:'邮箱',value:'email'},
              {label:'权限',value:'permission'}
            ]
        }
    },
    mounted(){
      this.loadData()
      this.loadRole()
      this.loadPermission()
      this.permission = this.$store.state.user.permission.join(',')
    },
    methods:{
        handleFilterUser(){
          if (this.querySelect == "") {
              this.$message({
                  type: 'warning',
                  message: '请选择查询字段!'
              });
          }else{
              this.loadData()
          }
          // else if (this.queryContent == "") {
          //     this.$message({
          //         type: 'warning',
          //         message: '请输入查询内容!'
          //     });
          // }else{
              
          // }
        },
        handleSizeChange(val) {
          this.pageSize = val
        },
        handleCurrentChange(val) {
          this.currentPage = val
          this.loadData()
        },
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
            let param = new URLSearchParams()
            param.append('index',this.currentPage)
            param.append('pagesize', this.pageSize)
            param.append('queryValue',this.querySelect)
            param.append('queryText',this.queryContent)
            this.$axios.post('/apis/getUserList',param).then(res=>{
                if (res.status === 200) {
                    if(res.data.status === 0){
                        this.total = res.data.total;
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
            this.$axios.post('/apis/getRoleList').then(res=>{
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
          this.dialogTitle = "添加用户";
        },
        confirmAddUser(){
          this.$refs['UserForm'].validate((valid) => {
            if(valid){
              console.log(this.UserForm);
              let param = new URLSearchParams()
              param.append('user_id', this.UserForm.user_id ? this.UserForm.user_id: -1)
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
            }
          })
        },
        handleUpdateUser(row){
          this.dialogTitle = "修改用户信息"
          this.dialogVisible = true;
          this.UserForm.user_id = row.user_id;
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