; ModuleID = 'sum-3.ll.init'
source_filename = "sum-3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@seed = internal unnamed_addr global i64 0, align 8
@size1 = internal unnamed_addr global i32 0, align 4
@size2 = internal unnamed_addr global i32 0, align 4
@size3 = internal unnamed_addr global i32 0, align 4
@ima = internal unnamed_addr global ptr null, align 8
@imb = internal unnamed_addr global ptr null, align 8
@imr = internal unnamed_addr global ptr null, align 8

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @Initrand() local_unnamed_addr #0 {
  store i64 8232, ptr @seed, align 8, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local range(i32 0, 65536) i32 @Rand() local_unnamed_addr #1 {
  %1 = load i64, ptr @seed, align 8, !tbaa !5
  %2 = mul nuw nsw i64 %1, 1309
  %3 = add nuw nsw i64 %2, 13849
  %4 = and i64 %3, 65535
  store i64 %4, ptr @seed, align 8, !tbaa !5
  %5 = trunc nuw nsw i64 %4 to i32
  ret i32 %5
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: write, inaccessiblemem: none) uwtable
define dso_local void @InitArray(ptr nocapture noundef writeonly %0, i32 noundef %1) local_unnamed_addr #2 {
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %.lr.ph.preheader, label %11

.lr.ph.preheader:                                 ; preds = %2
  %seed.promoted = load i64, ptr @seed, align 8, !tbaa !5
  %seed.promoted.fr = freeze i64 %seed.promoted
  %wide.trip.count = zext nneg i32 %1 to i64
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph.preheader ], [ %indvars.iv.next, %.lr.ph ]
  %4 = phi i64 [ %seed.promoted.fr, %.lr.ph.preheader ], [ %7, %.lr.ph ]
  %5 = mul i64 %4, 1309
  %6 = add i64 %5, 13849
  %7 = and i64 %6, 65535
  %.lhs.trunc = trunc i64 %6 to i16
  %8 = urem i16 %.lhs.trunc, 120
  %.zext = zext nneg i16 %8 to i32
  %9 = add nsw i32 %.zext, -60
  %10 = getelementptr inbounds i32, ptr %0, i64 %indvars.iv
  store i32 %9, ptr %10, align 4, !tbaa !9
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %._crit_edge, label %.lr.ph, !llvm.loop !11

._crit_edge:                                      ; preds = %.lr.ph
  store i64 %7, ptr @seed, align 8, !tbaa !5
  br label %11

11:                                               ; preds = %._crit_edge, %2
  ret void
}

; Function Attrs: nounwind memory(readwrite, argmem: none) uwtable
define dso_local range(i32 0, 2) i32 @init(i32 noundef %0) local_unnamed_addr #3 {
  store i32 %0, ptr @size1, align 4, !tbaa !9
  store i32 %0, ptr @size2, align 4, !tbaa !9
  store i32 %0, ptr @size3, align 4, !tbaa !9
  %2 = sext i32 %0 to i64
  %3 = tail call ptr @calloc(i64 noundef %2, i64 noundef 4) #10
  store ptr %3, ptr @ima, align 8, !tbaa !14
  %.not = icmp eq ptr %3, null
  br i1 %.not, label %InitArray.exit20, label %4

4:                                                ; preds = %1
  %5 = tail call ptr @calloc(i64 noundef %2, i64 noundef 4) #10
  store ptr %5, ptr @imb, align 8, !tbaa !14
  %.not7 = icmp eq ptr %5, null
  br i1 %.not7, label %6, label %7

6:                                                ; preds = %4
  tail call void @free(ptr noundef nonnull %3)
  br label %InitArray.exit20

7:                                                ; preds = %4
  %8 = tail call ptr @calloc(i64 noundef %2, i64 noundef 4) #10
  store ptr %8, ptr @imr, align 8, !tbaa !14
  %.not8 = icmp eq ptr %8, null
  br i1 %.not8, label %9, label %10

9:                                                ; preds = %7
  tail call void @free(ptr noundef nonnull %3)
  tail call void @free(ptr noundef nonnull %5)
  br label %InitArray.exit20

10:                                               ; preds = %7
  store i64 8232, ptr @seed, align 8, !tbaa !5
  %11 = icmp sgt i32 %0, 0
  br i1 %11, label %.lr.ph.preheader.i, label %InitArray.exit20

.lr.ph.preheader.i:                               ; preds = %10
  %wide.trip.count.i = zext nneg i32 %0 to i64
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i, %.lr.ph.preheader.i
  %indvars.iv.i = phi i64 [ 0, %.lr.ph.preheader.i ], [ %indvars.iv.next.i, %.lr.ph.i ]
  %12 = phi i64 [ 8232, %.lr.ph.preheader.i ], [ %15, %.lr.ph.i ]
  %13 = mul nuw nsw i64 %12, 1309
  %14 = add nuw nsw i64 %13, 13849
  %15 = and i64 %14, 65535
  %.lhs.trunc.i = trunc i64 %14 to i16
  %16 = urem i16 %.lhs.trunc.i, 120
  %.zext.i = zext nneg i16 %16 to i32
  %17 = add nsw i32 %.zext.i, -60
  %18 = getelementptr inbounds i32, ptr %3, i64 %indvars.iv.i
  store i32 %17, ptr %18, align 4, !tbaa !9
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i
  br i1 %exitcond.not.i, label %.lr.ph.i13, label %.lr.ph.i, !llvm.loop !11

.lr.ph.i13:                                       ; preds = %.lr.ph.i, %.lr.ph.i13
  %indvars.iv.i14 = phi i64 [ %indvars.iv.next.i17, %.lr.ph.i13 ], [ 0, %.lr.ph.i ]
  %19 = phi i64 [ %22, %.lr.ph.i13 ], [ %15, %.lr.ph.i ]
  %20 = mul nuw nsw i64 %19, 1309
  %21 = add nuw nsw i64 %20, 13849
  %22 = and i64 %21, 65535
  %.lhs.trunc.i15 = trunc i64 %21 to i16
  %23 = urem i16 %.lhs.trunc.i15, 120
  %.zext.i16 = zext nneg i16 %23 to i32
  %24 = add nsw i32 %.zext.i16, -60
  %25 = getelementptr inbounds i32, ptr %5, i64 %indvars.iv.i14
  store i32 %24, ptr %25, align 4, !tbaa !9
  %indvars.iv.next.i17 = add nuw nsw i64 %indvars.iv.i14, 1
  %exitcond.not.i18 = icmp eq i64 %indvars.iv.next.i17, %wide.trip.count.i
  br i1 %exitcond.not.i18, label %._crit_edge.i19, label %.lr.ph.i13, !llvm.loop !11

._crit_edge.i19:                                  ; preds = %.lr.ph.i13
  store i64 %22, ptr @seed, align 8, !tbaa !5
  br label %InitArray.exit20

InitArray.exit20:                                 ; preds = %10, %._crit_edge.i19, %1, %9, %6
  %.0 = phi i32 [ 0, %9 ], [ 0, %6 ], [ 0, %1 ], [ 1, %._crit_edge.i19 ], [ 1, %10 ]
  ret i32 %.0
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @calloc(i64 noundef, i64 noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn uwtable
define dso_local void @deinit() local_unnamed_addr #6 {
  %1 = load ptr, ptr @ima, align 8, !tbaa !14
  tail call void @free(ptr noundef %1)
  %2 = load ptr, ptr @imb, align 8, !tbaa !14
  tail call void @free(ptr noundef %2)
  %3 = load ptr, ptr @imr, align 8, !tbaa !14
  tail call void @free(ptr noundef %3)
  ret void
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @sum_3() local_unnamed_addr #7 {
  %1 = load i32, ptr @size1, align 4, !tbaa !9
  %2 = load i32, ptr @size2, align 4, !tbaa !9
  %3 = load i32, ptr @size3, align 4, !tbaa !9
  %4 = icmp sgt i32 %1, 0
  br i1 %4, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %5 = load ptr, ptr @ima, align 8, !tbaa !14
  %6 = ptrtoint ptr %5 to i64
  %.not = icmp eq ptr %5, null
  %7 = load ptr, ptr @imb, align 8
  %.fr52 = freeze ptr %7
  %.fr5262 = ptrtoint ptr %.fr52 to i64
  %8 = load ptr, ptr @imr, align 8
  %.fr = freeze ptr %8
  %.fr61 = ptrtoint ptr %.fr to i64
  %.not54 = icmp eq ptr %.fr, null
  br i1 %.not, label %23, label %.lr.ph.split

.lr.ph.split:                                     ; preds = %.lr.ph
  %.not53 = icmp eq ptr %.fr52, null
  br i1 %.not53, label %.split, label %.lr.ph.split.split

.lr.ph.split.split:                               ; preds = %.lr.ph.split
  br i1 %.not54, label %.lr.ph.split.split.split.us, label %.lr.ph.split.split.split.preheader

.lr.ph.split.split.split.preheader:               ; preds = %.lr.ph.split.split
  %smax = tail call i32 @llvm.smax.i32(i32 %2, i32 0)
  %wide.trip.count = zext nneg i32 %smax to i64
  %smax56 = tail call i32 @llvm.smax.i32(i32 %3, i32 0)
  %wide.trip.count57 = zext nneg i32 %smax56 to i64
  %wide.trip.count59 = zext nneg i32 %1 to i64
  %9 = add nsw i64 %wide.trip.count59, -1
  %umin = tail call i64 @llvm.umin.i64(i64 %9, i64 %wide.trip.count57)
  %10 = freeze i64 %umin
  %umin64 = tail call i64 @llvm.umin.i64(i64 %10, i64 %wide.trip.count)
  %11 = add nuw nsw i64 %umin64, 1
  %min.iters.check = icmp ult i64 %umin64, 16
  br i1 %min.iters.check, label %.lr.ph.split.split.split.preheader66, label %vector.memcheck

.lr.ph.split.split.split.preheader66:             ; preds = %middle.block, %vector.memcheck, %.lr.ph.split.split.split.preheader
  %indvars.iv.ph = phi i64 [ 0, %vector.memcheck ], [ 0, %.lr.ph.split.split.split.preheader ], [ %n.vec, %middle.block ]
  %.046.ph = phi i32 [ 0, %vector.memcheck ], [ 0, %.lr.ph.split.split.split.preheader ], [ %22, %middle.block ]
  br label %.lr.ph.split.split.split

vector.memcheck:                                  ; preds = %.lr.ph.split.split.split.preheader
  %12 = sub i64 %.fr61, %6
  %diff.check = icmp ult i64 %12, 256
  %13 = sub i64 %.fr61, %.fr5262
  %diff.check63 = icmp ult i64 %13, 256
  %conflict.rdx = or i1 %diff.check, %diff.check63
  br i1 %conflict.rdx, label %.lr.ph.split.split.split.preheader66, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %n.mod.vf = and i64 %11, 15
  %14 = icmp eq i64 %n.mod.vf, 0
  %15 = select i1 %14, i64 16, i64 %n.mod.vf
  %n.vec = sub nsw i64 %11, %15
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %20, %vector.body ]
  %16 = getelementptr inbounds i32, ptr %5, i64 %index
  %wide.load = load <16 x i32>, ptr %16, align 4, !tbaa !9
  %17 = getelementptr inbounds i32, ptr %.fr52, i64 %index
  %wide.load65 = load <16 x i32>, ptr %17, align 4, !tbaa !9
  %18 = add nsw <16 x i32> %wide.load65, %wide.load
  %19 = getelementptr inbounds i32, ptr %.fr, i64 %index
  store <16 x i32> %18, ptr %19, align 4, !tbaa !9
  %20 = add <16 x i32> %18, %vec.phi
  %index.next = add nuw i64 %index, 16
  %21 = icmp eq i64 %index.next, %n.vec
  br i1 %21, label %middle.block, label %vector.body, !llvm.loop !16

middle.block:                                     ; preds = %vector.body
  %22 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %20)
  br label %.lr.ph.split.split.split.preheader66

.lr.ph.split.split.split.us:                      ; preds = %.lr.ph.split.split
  %.not38.us = icmp sgt i32 %2, 0
  br i1 %.not38.us, label %.split50.us, label %.split

._crit_edge:                                      ; preds = %25, %0
  %.0.lcssa = phi i32 [ 0, %0 ], [ %32, %25 ]
  ret i32 %.0.lcssa

.lr.ph.split.split.split:                         ; preds = %.lr.ph.split.split.split.preheader66, %25
  %indvars.iv = phi i64 [ %indvars.iv.next, %25 ], [ %indvars.iv.ph, %.lr.ph.split.split.split.preheader66 ]
  %.046 = phi i32 [ %32, %25 ], [ %.046.ph, %.lr.ph.split.split.split.preheader66 ]
  %exitcond.not = icmp eq i64 %indvars.iv, %wide.trip.count
  br i1 %exitcond.not, label %.split, label %24

23:                                               ; preds = %.lr.ph
  tail call void @abort() #11
  unreachable

.split:                                           ; preds = %.lr.ph.split.split.split, %.lr.ph.split.split.split.us, %.lr.ph.split
  tail call void @abort() #11
  unreachable

24:                                               ; preds = %.lr.ph.split.split.split
  %exitcond58.not = icmp eq i64 %indvars.iv, %wide.trip.count57
  br i1 %exitcond58.not, label %.split50.us, label %25

.split50.us:                                      ; preds = %24, %.lr.ph.split.split.split.us
  tail call void @abort() #11
  unreachable

25:                                               ; preds = %24
  %26 = getelementptr inbounds i32, ptr %5, i64 %indvars.iv
  %27 = load i32, ptr %26, align 4, !tbaa !9
  %28 = getelementptr inbounds i32, ptr %.fr52, i64 %indvars.iv
  %29 = load i32, ptr %28, align 4, !tbaa !9
  %30 = add nsw i32 %29, %27
  %31 = getelementptr inbounds i32, ptr %.fr, i64 %indvars.iv
  store i32 %30, ptr %31, align 4, !tbaa !9
  %32 = add i32 %30, %.046
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond60.not = icmp eq i64 %indvars.iv.next, %wide.trip.count59
  br i1 %exitcond60.not, label %._crit_edge, label %.lr.ph.split.split.split, !llvm.loop !19
}

; Function Attrs: cold nofree noreturn nounwind
declare void @abort() local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #9

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #2 = { nofree norecurse nosync nounwind memory(readwrite, argmem: write, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #3 = { nounwind memory(readwrite, argmem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #6 = { mustprogress nounwind willreturn uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #7 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #8 = { cold nofree noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cascadelake" "target-features"="+prfchw,-cldemote,+avx,+aes,+sahf,+pclmul,-xop,+crc32,-xsaves,-avx512fp16,-usermsr,-sm4,-egpr,+sse4.1,-avx512ifma,+xsave,+sse4.2,-tsxldtrk,-sm3,-ptwrite,-widekl,+invpcid,+64bit,+xsavec,-avx10.1-512,-avx512vpopcntdq,+cmov,-avx512vp2intersect,+avx512cd,+movbe,-avxvnniint8,-ccmp,-amx-int8,-kl,-avx10.1-256,+evex512,-avxvnni,+rtm,+adx,+avx2,-hreset,-movdiri,-serialize,-sha512,-vpclmulqdq,+avx512vl,-uintr,-cf,+clflushopt,-raoint,-cmpccxadd,+bmi,-amx-tile,+sse,-gfni,-avxvnniint16,-amx-fp16,-ndd,+xsaveopt,+rdrnd,+avx512f,-amx-bf16,-avx512bf16,+avx512vnni,-push2pop2,+cx8,+avx512bw,+sse3,-pku,+fsgsbase,-clzero,-mwaitx,-lwp,+lzcnt,-sha,-movdir64b,-ppx,-wbnoinvd,-enqcmd,-avxneconvert,-tbm,-pconfig,-amx-complex,+ssse3,+cx16,+bmi2,+fma,+popcnt,-avxifma,+f16c,-avx512bitalg,-rdpru,+clwb,+mmx,+sse2,+rdseed,-avx512vbmi2,-prefetchi,-rdpid,-fma4,-avx512vbmi,-shstk,-vaes,-waitpkg,-sgx,+fxsr,+avx512dq,-sse4a," "tune-cpu"="generic" }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { allocsize(0,1) }
attributes #11 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 19.1.2 (++20241028122730+d8752671e825-1~exp1~20241028122742.57)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"long", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !7, i64 0}
!11 = distinct !{!11, !12, !13}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!"llvm.loop.unroll.disable"}
!14 = !{!15, !15, i64 0}
!15 = !{!"any pointer", !7, i64 0}
!16 = distinct !{!16, !12, !13, !17, !18}
!17 = !{!"llvm.loop.isvectorized", i32 1}
!18 = !{!"llvm.loop.unroll.runtime.disable"}
!19 = distinct !{!19, !12, !13, !17}
