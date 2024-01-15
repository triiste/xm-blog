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
      title:this.$route.query.title
    }
  }
}
</script>

<style>

</style>