# Chapter One : All you need is lambda
---

### Intermission exercises 👨‍🦳

1. λ*xy.xz*
   1. b)
2. λ*xy.xxy*
   1. c)
3. λ*xyz.zx*
   1. b)

### Chaper exercises

**Combinators**
1. Yes, I am a combinator
2. No, Iam not a combinator
3. Yes, I am a combinator
4. Yes, I am a combinator
5. No, I am not a combinator

**Normal Form or Diverge?**
1. I diverge
2. I diverge
3. I am normal form

**Beta Reduction**
1. *(λabc.cba)zz(λwv.w)*
   1. *(λa.λb.λc.cba)zz(λw.λv.w)*
   2. *(λv.z)z*
   3. z

2. *(λx.λy.xyy)(λa.ab)*
   1. *(λy.(λa.ab)yy)*
   2. *(λy.(λa.ab)yy)*
   3. *((λa.ab)(λa.ab))*
   4. ((λa.ab)b)
   5. bb

3. *(λy.y)(λx.xx)(λz.zq)*
   1. *(λx.xx)(λz.zq)*
   2. *(λz.zq)(λz.zq)*
   3. *(λz.zq)(q)*
   4. *qq*

4. *(λz.z)(λz.zz)(λz.zy)*
   1. *(λz.zz)(λz.zy)*
   2. *(λz.zy)(λz.zy)*
   3. *(λz.zy)(y)*
   4. *yy*

5. *(λx.λy.xyy)(λy.y)y*
   1. *(λy.(λy.y)yy)y*
   2.  *((λy.y)(λy.y)y)*
   3.  *(λy.y)y*
   4.  *yy*

6. *(λa.aa)(λb.ba)c*
   1. *((λb.ba)(λb.ba)c)*
   2. *(λb.ba)a)(c)*
   3. *aac*

7. *(λxyz.xz(yz))(λx.z)(λx.a)*
   1. *(λx.λy.λz.xz(yz))(λx.z)(λx.a)*
   2. *(λy.λz1.(λx.z)z1(yz1))(λx.a)*
   3. *(λz1.(λx.z)(z1)((λx.a)z1))*
   4. *(λz1.z((λx.a)z1)))*
   5. *(λz1.za)*