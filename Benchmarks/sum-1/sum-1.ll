; ModuleID = './sum-1.c'
source_filename = "./sum-1.c"

@seed = internal global i64 0, align 8
@size = internal global i32 0, align 4
@ima = internal global ptr null, align 8
@imb = internal global ptr null, align 8
@imr = internal global ptr null, align 8

; Function Attrs: nounwind uwtable
define dso_local void @Initrand() #0 {
  store i64 74755, ptr @seed, align 8, !tbaa !5
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Rand() #0 {
  %1 = load i64, ptr @seed, align 8, !tbaa !5
  %2 = mul nsw i64 %1, 1309
  %3 = add nsw i64 %2, 13849
  %4 = and i64 %3, 65535
  store i64 %4, ptr @seed, align 8, !tbaa !5
  %5 = load i64, ptr @seed, align 8, !tbaa !5
  %6 = trunc i64 %5 to i32
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define dso_local void @InitArray(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #4
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #4
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #4
  store i32 0, ptr %4, align 4, !tbaa !11
  br label %6

6:                                                ; preds = %22, %1
  %7 = load i32, ptr %4, align 4, !tbaa !11
  %8 = load i32, ptr @size, align 4, !tbaa !11
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %25

10:                                               ; preds = %6
  %11 = call i32 @Rand()
  store i32 %11, ptr %3, align 4, !tbaa !11
  %12 = load i32, ptr %3, align 4, !tbaa !11
  %13 = load i32, ptr %3, align 4, !tbaa !11
  %14 = sdiv i32 %13, 120
  %15 = mul nsw i32 %14, 120
  %16 = sub nsw i32 %12, %15
  %17 = sub nsw i32 %16, 60
  %18 = load ptr, ptr %2, align 8, !tbaa !9
  %19 = load i32, ptr %4, align 4, !tbaa !11
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %18, i64 %20
  store i32 %17, ptr %21, align 4, !tbaa !11
  br label %22

22:                                               ; preds = %10
  %23 = load i32, ptr %4, align 4, !tbaa !11
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %4, align 4, !tbaa !11
  br label %6, !llvm.loop !13

25:                                               ; preds = %6
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #4
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #4
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #4
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @init(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4, !tbaa !11
  %4 = load i32, ptr %3, align 4, !tbaa !11
  store i32 %4, ptr @size, align 4, !tbaa !11
  %5 = load i32, ptr %3, align 4, !tbaa !11
  %6 = sext i32 %5 to i64
  %7 = call ptr @calloc(i64 noundef %6, i64 noundef 4) #5
  store ptr %7, ptr @ima, align 8, !tbaa !9
  %8 = load ptr, ptr @ima, align 8, !tbaa !9
  %9 = icmp ne ptr %8, null
  br i1 %9, label %11, label %10

10:                                               ; preds = %1
  store i32 0, ptr %2, align 4
  br label %31

11:                                               ; preds = %1
  %12 = load i32, ptr %3, align 4, !tbaa !11
  %13 = sext i32 %12 to i64
  %14 = call ptr @calloc(i64 noundef %13, i64 noundef 4) #5
  store ptr %14, ptr @imb, align 8, !tbaa !9
  %15 = load ptr, ptr @imb, align 8, !tbaa !9
  %16 = icmp ne ptr %15, null
  br i1 %16, label %19, label %17

17:                                               ; preds = %11
  %18 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %18)
  store i32 0, ptr %2, align 4
  br label %31

19:                                               ; preds = %11
  %20 = load i32, ptr %3, align 4, !tbaa !11
  %21 = sext i32 %20 to i64
  %22 = call ptr @calloc(i64 noundef %21, i64 noundef 4) #5
  store ptr %22, ptr @imr, align 8, !tbaa !9
  %23 = load ptr, ptr @imr, align 8, !tbaa !9
  %24 = icmp ne ptr %23, null
  br i1 %24, label %28, label %25

25:                                               ; preds = %19
  %26 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %26)
  %27 = load ptr, ptr @imb, align 8, !tbaa !9
  call void @free(ptr noundef %27)
  store i32 0, ptr %2, align 4
  br label %31

28:                                               ; preds = %19
  call void @Initrand()
  %29 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @InitArray(ptr noundef %29)
  %30 = load ptr, ptr @imb, align 8, !tbaa !9
  call void @InitArray(ptr noundef %30)
  store i32 1, ptr %2, align 4
  br label %31

31:                                               ; preds = %28, %25, %17, %10
  %32 = load i32, ptr %2, align 4
  ret i32 %32
}

; Function Attrs: allocsize(0,1)
declare ptr @calloc(i64 noundef, i64 noundef) #2

declare void @free(ptr noundef) #3

; Function Attrs: nounwind uwtable
define dso_local void @deinit() #0 {
  %1 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %1)
  %2 = load ptr, ptr @imb, align 8, !tbaa !9
  call void @free(ptr noundef %2)
  %3 = load ptr, ptr @imr, align 8, !tbaa !9
  call void @free(ptr noundef %3)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @sum_1() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %1) #4
  call void @llvm.lifetime.start.p0(i64 4, ptr %2) #4
  %4 = load i32, ptr @size, align 4, !tbaa !11
  store i32 %4, ptr %2, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #4
  store i32 0, ptr %3, align 4, !tbaa !11
  store i32 0, ptr %1, align 4, !tbaa !11
  br label %5

5:                                                ; preds = %32, %0
  %6 = load i32, ptr %1, align 4, !tbaa !11
  %7 = load i32, ptr %2, align 4, !tbaa !11
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %35

9:                                                ; preds = %5
  %10 = load ptr, ptr @ima, align 8, !tbaa !9
  %11 = load i32, ptr %1, align 4, !tbaa !11
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i32, ptr %10, i64 %12
  %14 = load i32, ptr %13, align 4, !tbaa !11
  %15 = load ptr, ptr @imb, align 8, !tbaa !9
  %16 = load i32, ptr %1, align 4, !tbaa !11
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i32, ptr %15, i64 %17
  %19 = load i32, ptr %18, align 4, !tbaa !11
  %20 = add nsw i32 %14, %19
  %21 = load ptr, ptr @imr, align 8, !tbaa !9
  %22 = load i32, ptr %1, align 4, !tbaa !11
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds i32, ptr %21, i64 %23
  store i32 %20, ptr %24, align 4, !tbaa !11
  %25 = load ptr, ptr @imr, align 8, !tbaa !9
  %26 = load i32, ptr %1, align 4, !tbaa !11
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds i32, ptr %25, i64 %27
  %29 = load i32, ptr %28, align 4, !tbaa !11
  %30 = load i32, ptr %3, align 4, !tbaa !11
  %31 = add i32 %30, %29
  store i32 %31, ptr %3, align 4, !tbaa !11
  br label %32

32:                                               ; preds = %9
  %33 = load i32, ptr %1, align 4, !tbaa !11
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %1, align 4, !tbaa !11
  br label %5, !llvm.loop !16

35:                                               ; preds = %5
  %36 = load i32, ptr %3, align 4, !tbaa !11
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #4
  call void @llvm.lifetime.end.p0(i64 4, ptr %2) #4
  call void @llvm.lifetime.end.p0(i64 4, ptr %1) #4
  ret i32 %36
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { allocsize(0,1) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #4 = { nounwind }
attributes #5 = { allocsize(0,1) }

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
!10 = !{!"any pointer", !7, i64 0}
!11 = !{!12, !12, i64 0}
!12 = !{!"int", !7, i64 0}
!13 = distinct !{!13, !14, !15}
!14 = !{!"llvm.loop.mustprogress"}
!15 = !{!"llvm.loop.unroll.disable"}
!16 = distinct !{!16, !14, !15}
