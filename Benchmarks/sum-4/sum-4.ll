; ModuleID = 'sum-4.c'
source_filename = "sum-4.c"

@seed = internal global i64 0, align 8
@size = internal global i32 0, align 4
@ima = internal global ptr null, align 8
@imb = internal global ptr null, align 8
@imr = internal global ptr null, align 8

; Function Attrs: nounwind uwtable
define dso_local void @Initrand() #0 {
  store i64 8232, ptr @seed, align 8, !tbaa !5
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
define dso_local void @InitArray(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8, !tbaa !9
  store i32 %1, ptr %4, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #5
  store i32 0, ptr %6, align 4, !tbaa !11
  br label %8

8:                                                ; preds = %24, %2
  %9 = load i32, ptr %6, align 4, !tbaa !11
  %10 = load i32, ptr %4, align 4, !tbaa !11
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %27

12:                                               ; preds = %8
  %13 = call i32 @Rand()
  store i32 %13, ptr %5, align 4, !tbaa !11
  %14 = load i32, ptr %5, align 4, !tbaa !11
  %15 = load i32, ptr %5, align 4, !tbaa !11
  %16 = sdiv i32 %15, 120
  %17 = mul nsw i32 %16, 120
  %18 = sub nsw i32 %14, %17
  %19 = sub nsw i32 %18, 60
  %20 = load ptr, ptr %3, align 8, !tbaa !9
  %21 = load i32, ptr %6, align 4, !tbaa !11
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds i32, ptr %20, i64 %22
  store i32 %19, ptr %23, align 4, !tbaa !11
  br label %24

24:                                               ; preds = %12
  %25 = load i32, ptr %6, align 4, !tbaa !11
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %6, align 4, !tbaa !11
  br label %8, !llvm.loop !13

27:                                               ; preds = %8
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #5
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
  %7 = call ptr @calloc(i64 noundef %6, i64 noundef 4) #6
  store ptr %7, ptr @ima, align 8, !tbaa !9
  %8 = load ptr, ptr @ima, align 8, !tbaa !9
  %9 = icmp ne ptr %8, null
  br i1 %9, label %11, label %10

10:                                               ; preds = %1
  store i32 0, ptr %2, align 4
  br label %33

11:                                               ; preds = %1
  %12 = load i32, ptr %3, align 4, !tbaa !11
  %13 = sext i32 %12 to i64
  %14 = call ptr @calloc(i64 noundef %13, i64 noundef 4) #6
  store ptr %14, ptr @imb, align 8, !tbaa !9
  %15 = load ptr, ptr @imb, align 8, !tbaa !9
  %16 = icmp ne ptr %15, null
  br i1 %16, label %19, label %17

17:                                               ; preds = %11
  %18 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %18)
  store i32 0, ptr %2, align 4
  br label %33

19:                                               ; preds = %11
  %20 = load i32, ptr %3, align 4, !tbaa !11
  %21 = sext i32 %20 to i64
  %22 = call ptr @calloc(i64 noundef %21, i64 noundef 4) #6
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
  br label %33

28:                                               ; preds = %19
  call void @Initrand()
  %29 = load ptr, ptr @ima, align 8, !tbaa !9
  %30 = load i32, ptr @size, align 4, !tbaa !11
  call void @InitArray(ptr noundef %29, i32 noundef %30)
  %31 = load ptr, ptr @imb, align 8, !tbaa !9
  %32 = load i32, ptr @size, align 4, !tbaa !11
  call void @InitArray(ptr noundef %31, i32 noundef %32)
  store i32 1, ptr %2, align 4
  br label %33

33:                                               ; preds = %28, %25, %17, %10
  %34 = load i32, ptr %2, align 4
  ret i32 %34
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
define dso_local i32 @read_arr(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %4, align 8, !tbaa !9
  store i32 %1, ptr %5, align 4, !tbaa !11
  store i32 %2, ptr %6, align 4, !tbaa !11
  %7 = load ptr, ptr %4, align 8, !tbaa !9
  %8 = icmp ne ptr %7, null
  br i1 %8, label %9, label %16

9:                                                ; preds = %3
  %10 = load i32, ptr %6, align 4, !tbaa !11
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %16, label %12

12:                                               ; preds = %9
  %13 = load i32, ptr %6, align 4, !tbaa !11
  %14 = load i32, ptr %5, align 4, !tbaa !11
  %15 = icmp sge i32 %13, %14
  br i1 %15, label %16, label %17

16:                                               ; preds = %12, %9, %3
  call void @abort() #7
  unreachable

17:                                               ; preds = %12
  %18 = load ptr, ptr %4, align 8, !tbaa !9
  %19 = load i32, ptr %6, align 4, !tbaa !11
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %18, i64 %20
  %22 = load i32, ptr %21, align 4, !tbaa !11
  ret i32 %22
}

; Function Attrs: noreturn nounwind
declare void @abort() #4

; Function Attrs: nounwind uwtable
define dso_local void @write_arr(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %5, align 8, !tbaa !9
  store i32 %1, ptr %6, align 4, !tbaa !11
  store i32 %2, ptr %7, align 4, !tbaa !11
  store i32 %3, ptr %8, align 4, !tbaa !11
  %9 = load ptr, ptr %5, align 8, !tbaa !9
  %10 = icmp ne ptr %9, null
  br i1 %10, label %11, label %18

11:                                               ; preds = %4
  %12 = load i32, ptr %7, align 4, !tbaa !11
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %18, label %14

14:                                               ; preds = %11
  %15 = load i32, ptr %7, align 4, !tbaa !11
  %16 = load i32, ptr %6, align 4, !tbaa !11
  %17 = icmp sge i32 %15, %16
  br i1 %17, label %18, label %19

18:                                               ; preds = %14, %11, %4
  call void @abort() #7
  unreachable

19:                                               ; preds = %14
  %20 = load i32, ptr %8, align 4, !tbaa !11
  %21 = load ptr, ptr %5, align 8, !tbaa !9
  %22 = load i32, ptr %7, align 4, !tbaa !11
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds i32, ptr %21, i64 %23
  store i32 %20, ptr %24, align 4, !tbaa !11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @sum_4() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %1) #5
  %7 = load i32, ptr @size, align 4, !tbaa !11
  store i32 %7, ptr %1, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %2) #5
  store i32 0, ptr %2, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #5
  store i32 0, ptr %3, align 4, !tbaa !11
  br label %8

8:                                                ; preds = %35, %0
  %9 = load i32, ptr %3, align 4, !tbaa !11
  %10 = load i32, ptr %1, align 4, !tbaa !11
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %13, label %12

12:                                               ; preds = %8
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #5
  br label %38

13:                                               ; preds = %8
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #5
  %14 = load ptr, ptr @ima, align 8, !tbaa !9
  %15 = load i32, ptr %1, align 4, !tbaa !11
  %16 = load i32, ptr %3, align 4, !tbaa !11
  %17 = call i32 @read_arr(ptr noundef %14, i32 noundef %15, i32 noundef %16)
  store i32 %17, ptr %4, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #5
  %18 = load ptr, ptr @imb, align 8, !tbaa !9
  %19 = load i32, ptr %1, align 4, !tbaa !11
  %20 = load i32, ptr %3, align 4, !tbaa !11
  %21 = call i32 @read_arr(ptr noundef %18, i32 noundef %19, i32 noundef %20)
  store i32 %21, ptr %5, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #5
  %22 = load i32, ptr %4, align 4, !tbaa !11
  %23 = load i32, ptr %5, align 4, !tbaa !11
  %24 = add nsw i32 %22, %23
  store i32 %24, ptr %6, align 4, !tbaa !11
  %25 = load ptr, ptr @imr, align 8, !tbaa !9
  %26 = load i32, ptr %1, align 4, !tbaa !11
  %27 = load i32, ptr %3, align 4, !tbaa !11
  %28 = load i32, ptr %6, align 4, !tbaa !11
  call void @write_arr(ptr noundef %25, i32 noundef %26, i32 noundef %27, i32 noundef %28)
  %29 = load ptr, ptr @imr, align 8, !tbaa !9
  %30 = load i32, ptr %1, align 4, !tbaa !11
  %31 = load i32, ptr %3, align 4, !tbaa !11
  %32 = call i32 @read_arr(ptr noundef %29, i32 noundef %30, i32 noundef %31)
  %33 = load i32, ptr %2, align 4, !tbaa !11
  %34 = add i32 %33, %32
  store i32 %34, ptr %2, align 4, !tbaa !11
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #5
  br label %35

35:                                               ; preds = %13
  %36 = load i32, ptr %3, align 4, !tbaa !11
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %3, align 4, !tbaa !11
  br label %8, !llvm.loop !16

38:                                               ; preds = %12
  %39 = load i32, ptr %2, align 4, !tbaa !11
  call void @llvm.lifetime.end.p0(i64 4, ptr %2) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %1) #5
  ret i32 %39
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { allocsize(0,1) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { allocsize(0,1) }
attributes #7 = { noreturn nounwind }

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
