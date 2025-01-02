; ModuleID = 'sum-2.c'
source_filename = "sum-2.c"

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
define dso_local void @InitArray(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #5
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
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #5
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
  br label %31

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
  br label %31

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
define dso_local i32 @sum_2() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %1) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %2) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #5
  %9 = load i32, ptr @size, align 4, !tbaa !11
  store i32 %9, ptr %3, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #5
  store i32 0, ptr %4, align 4, !tbaa !11
  store i32 0, ptr %1, align 4, !tbaa !11
  br label %10

10:                                               ; preds = %85, %0
  %11 = load i32, ptr %1, align 4, !tbaa !11
  %12 = load i32, ptr %3, align 4, !tbaa !11
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %88

14:                                               ; preds = %10
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #5
  %15 = load ptr, ptr @ima, align 8, !tbaa !9
  %16 = icmp ne ptr %15, null
  br i1 %16, label %17, label %24

17:                                               ; preds = %14
  %18 = load i32, ptr %1, align 4, !tbaa !11
  %19 = icmp slt i32 %18, 0
  br i1 %19, label %24, label %20

20:                                               ; preds = %17
  %21 = load i32, ptr %1, align 4, !tbaa !11
  %22 = load i32, ptr %3, align 4, !tbaa !11
  %23 = icmp sge i32 %21, %22
  br i1 %23, label %24, label %25

24:                                               ; preds = %20, %17, %14
  call void @abort() #7
  unreachable

25:                                               ; preds = %20
  %26 = load ptr, ptr @ima, align 8, !tbaa !9
  %27 = load i32, ptr %1, align 4, !tbaa !11
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i32, ptr %26, i64 %28
  %30 = load i32, ptr %29, align 4, !tbaa !11
  store i32 %30, ptr %5, align 4, !tbaa !11
  %31 = load ptr, ptr @imb, align 8, !tbaa !9
  %32 = icmp ne ptr %31, null
  br i1 %32, label %33, label %40

33:                                               ; preds = %25
  %34 = load i32, ptr %1, align 4, !tbaa !11
  %35 = icmp slt i32 %34, 0
  br i1 %35, label %40, label %36

36:                                               ; preds = %33
  %37 = load i32, ptr %1, align 4, !tbaa !11
  %38 = load i32, ptr %3, align 4, !tbaa !11
  %39 = icmp sge i32 %37, %38
  br i1 %39, label %40, label %41

40:                                               ; preds = %36, %33, %25
  call void @abort() #7
  unreachable

41:                                               ; preds = %36
  %42 = load ptr, ptr @imb, align 8, !tbaa !9
  %43 = load i32, ptr %1, align 4, !tbaa !11
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds i32, ptr %42, i64 %44
  %46 = load i32, ptr %45, align 4, !tbaa !11
  store i32 %46, ptr %6, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #5
  %47 = load i32, ptr %5, align 4, !tbaa !11
  %48 = load i32, ptr %6, align 4, !tbaa !11
  %49 = add nsw i32 %47, %48
  store i32 %49, ptr %7, align 4, !tbaa !11
  %50 = load ptr, ptr @imr, align 8, !tbaa !9
  %51 = icmp ne ptr %50, null
  br i1 %51, label %52, label %59

52:                                               ; preds = %41
  %53 = load i32, ptr %1, align 4, !tbaa !11
  %54 = icmp slt i32 %53, 0
  br i1 %54, label %59, label %55

55:                                               ; preds = %52
  %56 = load i32, ptr %1, align 4, !tbaa !11
  %57 = load i32, ptr %3, align 4, !tbaa !11
  %58 = icmp sge i32 %56, %57
  br i1 %58, label %59, label %60

59:                                               ; preds = %55, %52, %41
  call void @abort() #7
  unreachable

60:                                               ; preds = %55
  %61 = load i32, ptr %7, align 4, !tbaa !11
  %62 = load ptr, ptr @imr, align 8, !tbaa !9
  %63 = load i32, ptr %1, align 4, !tbaa !11
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds i32, ptr %62, i64 %64
  store i32 %61, ptr %65, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #5
  %66 = load ptr, ptr @imr, align 8, !tbaa !9
  %67 = icmp ne ptr %66, null
  br i1 %67, label %68, label %75

68:                                               ; preds = %60
  %69 = load i32, ptr %1, align 4, !tbaa !11
  %70 = icmp slt i32 %69, 0
  br i1 %70, label %75, label %71

71:                                               ; preds = %68
  %72 = load i32, ptr %1, align 4, !tbaa !11
  %73 = load i32, ptr %3, align 4, !tbaa !11
  %74 = icmp sge i32 %72, %73
  br i1 %74, label %75, label %76

75:                                               ; preds = %71, %68, %60
  call void @abort() #7
  unreachable

76:                                               ; preds = %71
  %77 = load ptr, ptr @imr, align 8, !tbaa !9
  %78 = load i32, ptr %1, align 4, !tbaa !11
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds i32, ptr %77, i64 %79
  %81 = load i32, ptr %80, align 4, !tbaa !11
  store i32 %81, ptr %8, align 4, !tbaa !11
  %82 = load i32, ptr %8, align 4, !tbaa !11
  %83 = load i32, ptr %4, align 4, !tbaa !11
  %84 = add i32 %83, %82
  store i32 %84, ptr %4, align 4, !tbaa !11
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #5
  br label %85

85:                                               ; preds = %76
  %86 = load i32, ptr %1, align 4, !tbaa !11
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %1, align 4, !tbaa !11
  br label %10, !llvm.loop !16

88:                                               ; preds = %10
  %89 = load i32, ptr %4, align 4, !tbaa !11
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %2) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %1) #5
  ret i32 %89
}

; Function Attrs: noreturn nounwind
declare void @abort() #4

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
