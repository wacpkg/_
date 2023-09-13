<template lang="pug">
+if t == undefined
  s
  +else
    h3 {t}
    button(@click=x) >confirm
</template>

<script lang="coffee">
+ t

< x,gen

onMount =>
  await tick()
  t = await gen()
  return
</script>

