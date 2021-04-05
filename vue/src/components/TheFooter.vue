<template>
  <div>
    <div>
      <p>&#169; {{ copyText }}</p>
    </div>
    <div class="divTableHeading">
      <div class="divTableRow">
        <div class="divTableHead"></div>
        <span class="divTableHead">Contact</span>
        <span class="divTableHead">Age</span>
        <div class="divTableHead">Occupation</div>
        <div class="divTableHead">Description</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "the-footer",
  data() {
    return {
      copyText: "It's the cat's pajamas!",
    };
  },
};
</script>

<style>
</style>