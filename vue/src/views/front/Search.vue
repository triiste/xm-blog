<template>
  <div style="margin: 5px auto;width: 60%">
    <blog-list/>
  </div>
</template>

<script>
import BlogList from "@/components/BlogList";
export default {
  name: "Search",
  components: {BlogList},
  data(){
    return{
      title:this.$route.query.title === 'undefined'?'':this.$route.query.title,
      userName:this.$route.query.userName === 'undefined'?'':this.$route.query.userName,
      tags:this.$route.query.tags === 'undefined' ? '': this.$route.query.tags,
      content:this.$route.query.content === 'undefined' ? '': this.$route.query.content,
    }
  }
}
</script>

<style>

</style>