<template>
  <div class="catdetails">
    <div>
      <user-details></user-details>
    </div>
    <div>
      <div v-if="$store.state.token != '' && !firstTime ">
        <receive-message></receive-message>
      </div>
      <send-message></send-message>
    </div>
  </div>
</template>

<script>
import SendMessage from "../components/SendMessage.vue";
import UserDetails from "../components/UserDetails.vue";
import ReceiveMessage from "../components/ReceiveMessage.vue";

export default {

  
  name: "catdetails",
  components: {
    UserDetails,
    SendMessage,
    ReceiveMessage,
  },
  methods: {},
  created() {
    const catId = this.$route.params.id;
    this.$store.commit("SET_CATID", catId);
  },
};
</script>

<style>
</style>