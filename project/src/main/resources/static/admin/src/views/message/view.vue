<template>
    <el-main class="bg edit_wrap message">
        <el-form ref="form" :model="form" status-icon label-width="120px">
            <el-row class="row_e">
                <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="头像" prop="avatar">
                    <el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
                               action="" :http-request="uploadimg" :show-file-list="false">
                        <img v-if="form.avatar" :src="$fullUrl(form.avatar)" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="标题" prop="title">
                    <el-input v-model="form.title" placeholder="请输入标题"></el-input>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="昵称" prop="nickname">
                    <el-input v-model="form.nickname" :disabled="disabledObj.nickname_disabled" placeholder="请输入昵称"></el-input>
                </el-form-item>
            </el-col>

<!--            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">-->
<!--                <el-form-item label="留言手机号" prop="phone">-->
<!--                    <el-input v-model="form.phone" :disabled="disabledObj.phone_disabled" placeholder="请输入手机号码"></el-input>-->
<!--                </el-form-item>-->
<!--            </el-col>-->

<!--            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">-->
<!--                <el-form-item label="留言邮箱" prop="email">-->
<!--                    <el-input v-model="form.email" :disabled="disabledObj.email_disabled" placeholder="请输入留言邮箱"></el-input>-->
<!--                </el-form-item>-->
<!--            </el-col>-->

            <el-col :xs="24" :sm="24" :lg="24" class="editor el_form_editor_warp">
                <el-form-item label="内容" prop="content">
<!--                    <quill-editor v-model="form.content">-->
<!--                    </quill-editor>-->
                  <el-input
                      type="textarea"
                      v-model="form.content"
                      :readonly="true">
                  </el-input>
                </el-form-item>
            </el-col>

            </el-row>
            
            <el-col :xs="24" :sm="24" :lg="24" class="el_form_btn_warp">
                <el-form-item>
                    <el-col v-if="(form['message_id'] && $check_action('/message/view','set')) || (!form['message_id'] && $check_action('/message/view','add'))" :xs="24" :sm="24" :lg="12" class="el_form_btn el_form_btn_1">
                        <el-button style="width: 100%; float: left;" type="primary" @click="submit()">提交</el-button>
                    </el-col>
                    <el-col :xs="24" :sm="24" :lg="12" class="el_form_btn el_form_btn_2">
                        <el-button style="width: 100%; float: right;" @click="cancel()">取消</el-button>
                    </el-col>
                </el-form-item>
            </el-col>

        </el-form>
    </el-main>
</template>

<script>
    import mixin from "@/mixins/page.js";

    export default {
        mixins: [mixin],
        data() {
            return {

                table: "message",
                field: "message_id",

                url_add: "~/api/message/add?",
                url_set: "~/api/message/set?",
                url_get_obj: "~/api/message/get_obj?",
                url_upload: "~/api/message/upload?",

                query: {
                    message_id: 0
                },
                form: {
                    message_id: 0,
                    avatar: "",
                    title: "",
                    nickname: "",
                    // phone: "",
                    // email: "",
                    content:"",
                    reply_state: 0
                },

                list_message: [],
              disabledObj:{
                nickname_disabled:false,
                // email_disabled:false,
                // phone_disabled:false
              }
            }
        },
        methods: {
            submit_check(params) {
                var msg = "";
                if (params.title === "") {
                    msg = "标题不能为空";
                    return msg;
                }
                if (params.nickname === "") {
                    msg = "昵称不能为空";
                    return msg;
                }
                if (params.reply_id === -1) {
                    msg = "回复者错误";
                    return msg;
                }
            },
            /**
             * 上传文件
             * @param {Object} param
             */
            uploadimg(param) {
                this.uploadFile(param.file, "avatar");
            },

            // 获取用户列表
            async get_list_message() {
                var list = await this.$get("~/api/message/get_list?");
                this.list_message = list.result.list;
            }

        },
        created() {
            let user = this.$store.state.user;
            if (user && user.user_id){
              this.form.nickname = user.nickname;
              this.disabledObj.nickname_disabled = true;
              // if (user.email){
              //   this.form.email = user.email;
              //   this.disabledObj.email_disabled = true;
              // }
              // if (user.phone){
              //   this.form.phone = user.phone;
              //   this.disabledObj.phone_disabled = true;
              // }
            }
            this.get_list_message()
        }
    }
</script>

<style>
    .avatar-uploader .el-upload {
        border: 1px dashed #d9d9d9;
        border-radius: 6px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
    }

    .avatar-uploader .el-upload:hover {
        border-color: #409EFF;
    }

    .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 178px;
        height: 178px;
        line-height: 178px;
        text-align: center;
    }

    .avatar {
        width: 178px;
        height: 178px;
        display: block;
    }
</style>
