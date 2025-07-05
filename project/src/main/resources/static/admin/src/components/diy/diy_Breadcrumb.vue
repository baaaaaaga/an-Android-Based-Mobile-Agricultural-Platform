<template>
    <div class="breadcrumb_box"> 

        <slot>
          
            <el-breadcrumb separator="/"  v-for="(crumb, index) in crumbs" :key="index">

            <el-breadcrumb-item :to="'/'" style="color:aliceblue"  @click="tos">首页</el-breadcrumb-item >
            <el-breadcrumb-item ><span style="color:aliceblue">{{ clickedButtonId }}</span></el-breadcrumb-item>
            <el-breadcrumb-item  >
               <span style="color:rgb(243, 243, 243)">{{ crumb.label }}</span> 
            </el-breadcrumb-item>
               
            </el-breadcrumb>
          
        </slot>
        
    </div>
 
</template>

<script>

export default {
    props: {
			isCollapse: {
				trye: Boolean,
				default: true
			},
     
		},
  
        
        data() {
    return {
      crumbs: [],
      
      clickedButtonId: null
    };
  },
  watch: {
    '$route'() {
      this.updateCrumbs();
     
      let title_t = sessionStorage.getItem('title-text');
      this.clickedButtonId = title_t
      // sessionStorage.removeItem('title-text')
      this.tos()
    }
    
  },
  created() {
    this.updateCrumbs();
    
  },
  methods: {
   
 
    tos(){
      sessionStorage.setItem('title-text', "后台首页");
      
    },

    updateCrumbs() {
      
      const routes = this.$route.matched;
      const newCrumbs = routes
        .filter(route => route.meta && route.meta.title)
        .map(route => ({
          to: route.path,
          label: route.meta.title,
          title: route.meta.big_title
        }));
        
        newCrumbs.forEach((crumb) => {
    if (this.crumbs.length < 1) {
        this.crumbs.shift();
        
        this.crumbs.push(crumb);
        
    } else {
      this.crumbs.shift();
      this.crumbs.push(crumb);
    }
  });
 
    },
  
    
  },
  computed:{
    
  },
 
  
  
 
 
}
</script>

<style>
.breadcrumb_box {
  
    width: auto;
    display: flex;
    align-items: center;
}
</style>