<template>
  <div class="login-background">
    <el-form :model="ruleForm2" :rules="rules2" ref="ruleForm2" label-position="left" label-width="0px" class="demo-ruleForm login-container">
      <div class="title"><i class="el-icon-search"></i>meru
        <span class="subtitle">“クメル”で才能を検索</span>
      </div>
      <el-form-item prop="account">
        <el-input type="text" v-model="ruleForm2.account" auto-complete="off" placeholder="アカウント"></el-input>
      </el-form-item>
      <el-form-item prop="checkPass">
        <el-input type="password" v-model="ruleForm2.checkPass" auto-complete="off" placeholder="パスワード"></el-input>
      </el-form-item>
      <el-form-item style="width:100%;">
        <el-button type="primary" style="width:100%;" @click.native.prevent="handleSubmit2" :loading="logining">ログイン</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { requestLogin } from '../api/api';
  //import NProgress from 'nprogress'
  export default {
    data() {
      return {
        logining: false,
        ruleForm2: {
          account: 'admin',
          checkPass: '123456'
        },
        rules2: {
          account: [
            { required: true, message: 'アカウントを入力してください', trigger: 'blur' },
            //{ validator: validaePass }
          ],
          checkPass: [
            { required: true, message: 'パスワードを入力してください', trigger: 'blur' },
            //{ validator: validaePass2 }
          ]
        },
      };
    },
    methods: {
      handleReset2() {
        this.$refs.ruleForm2.resetFields();
      },
      handleSubmit2(ev) {
        var _this = this;
        this.$refs.ruleForm2.validate((valid) => {
          if (valid) {
            //_this.$router.replace('/table');
            this.logining = true;
            //NProgress.start();
            var loginParams = { username: this.ruleForm2.account, password: this.ruleForm2.checkPass };
            requestLogin(loginParams).then(data => {
              this.logining = false;
              //NProgress.done();
              let { msg, code, user } = data;
              if (code !== 200) {
                this.$message({
                  message: msg,
                  type: 'error'
                });
              } else {
                sessionStorage.setItem('user', JSON.stringify(user));
                this.$router.push({ path: '/user' });
              }
            });
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      }
    }
  }

</script>

<style lang="scss" scoped>
  .login-background {
    position: absolute;
    width: 100vw;
    height: 100vh;
    background: linear-gradient(to right, rgba(166, 255, 203, 0.9), rgba(18, 216, 250, 0.8), rgba(31, 162, 255, 0.9)) ,url(../assets/bg-login.jpg) center;
    background-size:cover;
    background-repeat:no-repeat;
    
  }
  .login-container {


    border-radius: 5px;
    background-clip: padding-box;
    margin: 180px auto;
    width: 350px;
    padding: 35px 35px 15px 35px;
    background: #fff;
    .title {
      margin: 0px auto 40px auto;
      text-align: center;
      color: #505458;
      font-size : 40px;
    }
    .subtitle {
      display : block;
      font-size : 12px;
      margin-top : 0.5rem;
    }
    .remember {
      margin: 0px 0px 35px 0px;
    }
  }
</style>