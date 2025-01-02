; ModuleID = 'qsort.c'
source_filename = "qsort.c"

%struct.element = type { i32, i32 }
%struct.complex = type { float, float }

@seed = dso_local global i64 0, align 8
@biggest = dso_local global i32 0, align 4
@littlest = dso_local global i32 0, align 4
@sortlist = dso_local global [5001 x i32] zeroinitializer, align 16
@value = dso_local global float 0.000000e+00, align 4
@fixed = dso_local global float 0.000000e+00, align 4
@floated = dso_local global float 0.000000e+00, align 4
@permarray = dso_local global [11 x i32] zeroinitializer, align 16
@pctr = dso_local global i32 0, align 4
@tree = dso_local global ptr null, align 8
@stack = dso_local global [4 x i32] zeroinitializer, align 16
@cellspace = dso_local global [19 x %struct.element] zeroinitializer, align 16
@freelist = dso_local global i32 0, align 4
@movesdone = dso_local global i32 0, align 4
@ima = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@imb = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@imr = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@rma = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@rmb = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@rmr = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@piececount = dso_local global [4 x i32] zeroinitializer, align 16
@class = dso_local global [13 x i32] zeroinitializer, align 16
@piecemax = dso_local global [13 x i32] zeroinitializer, align 16
@puzzl = dso_local global [512 x i32] zeroinitializer, align 16
@p = dso_local global [13 x [512 x i32]] zeroinitializer, align 16
@n = dso_local global i32 0, align 4
@kount = dso_local global i32 0, align 4
@top = dso_local global i32 0, align 4
@z = dso_local global [257 x %struct.complex] zeroinitializer, align 16
@w = dso_local global [257 x %struct.complex] zeroinitializer, align 16
@e = dso_local global [130 x %struct.complex] zeroinitializer, align 16
@zr = dso_local global float 0.000000e+00, align 4
@zi = dso_local global float 0.000000e+00, align 4

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
define dso_local void @Initarr() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 4, ptr %1) #2
  call void @llvm.lifetime.start.p0(i64 8, ptr %2) #2
  call void @Initrand()
  store i32 0, ptr @biggest, align 4, !tbaa !9
  store i32 0, ptr @littlest, align 4, !tbaa !9
  store i32 1, ptr %1, align 4, !tbaa !9
  br label %3

3:                                                ; preds = %44, %0
  %4 = load i32, ptr %1, align 4, !tbaa !9
  %5 = icmp sle i32 %4, 5000
  br i1 %5, label %6, label %47

6:                                                ; preds = %3
  %7 = call i32 @Rand()
  %8 = sext i32 %7 to i64
  store i64 %8, ptr %2, align 8, !tbaa !5
  %9 = load i64, ptr %2, align 8, !tbaa !5
  %10 = load i64, ptr %2, align 8, !tbaa !5
  %11 = sdiv i64 %10, 100000
  %12 = mul nsw i64 %11, 100000
  %13 = sub nsw i64 %9, %12
  %14 = sub nsw i64 %13, 50000
  %15 = trunc i64 %14 to i32
  %16 = load i32, ptr %1, align 4, !tbaa !9
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %17
  store i32 %15, ptr %18, align 4, !tbaa !9
  %19 = load i32, ptr %1, align 4, !tbaa !9
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %20
  %22 = load i32, ptr %21, align 4, !tbaa !9
  %23 = load i32, ptr @biggest, align 4, !tbaa !9
  %24 = icmp sgt i32 %22, %23
  br i1 %24, label %25, label %30

25:                                               ; preds = %6
  %26 = load i32, ptr %1, align 4, !tbaa !9
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %27
  %29 = load i32, ptr %28, align 4, !tbaa !9
  store i32 %29, ptr @biggest, align 4, !tbaa !9
  br label %43

30:                                               ; preds = %6
  %31 = load i32, ptr %1, align 4, !tbaa !9
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %32
  %34 = load i32, ptr %33, align 4, !tbaa !9
  %35 = load i32, ptr @littlest, align 4, !tbaa !9
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %42

37:                                               ; preds = %30
  %38 = load i32, ptr %1, align 4, !tbaa !9
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %39
  %41 = load i32, ptr %40, align 4, !tbaa !9
  store i32 %41, ptr @littlest, align 4, !tbaa !9
  br label %42

42:                                               ; preds = %37, %30
  br label %43

43:                                               ; preds = %42, %25
  br label %44

44:                                               ; preds = %43
  %45 = load i32, ptr %1, align 4, !tbaa !9
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %1, align 4, !tbaa !9
  br label %3, !llvm.loop !11

47:                                               ; preds = %3
  call void @llvm.lifetime.end.p0(i64 8, ptr %2) #2
  call void @llvm.lifetime.end.p0(i64 4, ptr %1) #2
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local void @Quicksort(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %4, align 8, !tbaa !14
  store i32 %1, ptr %5, align 4, !tbaa !9
  store i32 %2, ptr %6, align 4, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #2
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #2
  call void @llvm.lifetime.start.p0(i64 4, ptr %9) #2
  call void @llvm.lifetime.start.p0(i64 4, ptr %10) #2
  %11 = load i32, ptr %5, align 4, !tbaa !9
  store i32 %11, ptr %7, align 4, !tbaa !9
  %12 = load i32, ptr %6, align 4, !tbaa !9
  store i32 %12, ptr %8, align 4, !tbaa !9
  %13 = load ptr, ptr %4, align 8, !tbaa !14
  %14 = load i32, ptr %5, align 4, !tbaa !9
  %15 = load i32, ptr %6, align 4, !tbaa !9
  %16 = add nsw i32 %14, %15
  %17 = sdiv i32 %16, 2
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i32, ptr %13, i64 %18
  %20 = load i32, ptr %19, align 4, !tbaa !9
  store i32 %20, ptr %9, align 4, !tbaa !9
  br label %21

21:                                               ; preds = %74, %3
  br label %22

22:                                               ; preds = %30, %21
  %23 = load ptr, ptr %4, align 8, !tbaa !14
  %24 = load i32, ptr %7, align 4, !tbaa !9
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i32, ptr %23, i64 %25
  %27 = load i32, ptr %26, align 4, !tbaa !9
  %28 = load i32, ptr %9, align 4, !tbaa !9
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %33

30:                                               ; preds = %22
  %31 = load i32, ptr %7, align 4, !tbaa !9
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %7, align 4, !tbaa !9
  br label %22, !llvm.loop !16

33:                                               ; preds = %22
  br label %34

34:                                               ; preds = %42, %33
  %35 = load i32, ptr %9, align 4, !tbaa !9
  %36 = load ptr, ptr %4, align 8, !tbaa !14
  %37 = load i32, ptr %8, align 4, !tbaa !9
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds i32, ptr %36, i64 %38
  %40 = load i32, ptr %39, align 4, !tbaa !9
  %41 = icmp slt i32 %35, %40
  br i1 %41, label %42, label %45

42:                                               ; preds = %34
  %43 = load i32, ptr %8, align 4, !tbaa !9
  %44 = sub nsw i32 %43, 1
  store i32 %44, ptr %8, align 4, !tbaa !9
  br label %34, !llvm.loop !17

45:                                               ; preds = %34
  %46 = load i32, ptr %7, align 4, !tbaa !9
  %47 = load i32, ptr %8, align 4, !tbaa !9
  %48 = icmp sle i32 %46, %47
  br i1 %48, label %49, label %73

49:                                               ; preds = %45
  %50 = load ptr, ptr %4, align 8, !tbaa !14
  %51 = load i32, ptr %7, align 4, !tbaa !9
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds i32, ptr %50, i64 %52
  %54 = load i32, ptr %53, align 4, !tbaa !9
  store i32 %54, ptr %10, align 4, !tbaa !9
  %55 = load ptr, ptr %4, align 8, !tbaa !14
  %56 = load i32, ptr %8, align 4, !tbaa !9
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds i32, ptr %55, i64 %57
  %59 = load i32, ptr %58, align 4, !tbaa !9
  %60 = load ptr, ptr %4, align 8, !tbaa !14
  %61 = load i32, ptr %7, align 4, !tbaa !9
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds i32, ptr %60, i64 %62
  store i32 %59, ptr %63, align 4, !tbaa !9
  %64 = load i32, ptr %10, align 4, !tbaa !9
  %65 = load ptr, ptr %4, align 8, !tbaa !14
  %66 = load i32, ptr %8, align 4, !tbaa !9
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds i32, ptr %65, i64 %67
  store i32 %64, ptr %68, align 4, !tbaa !9
  %69 = load i32, ptr %7, align 4, !tbaa !9
  %70 = add nsw i32 %69, 1
  store i32 %70, ptr %7, align 4, !tbaa !9
  %71 = load i32, ptr %8, align 4, !tbaa !9
  %72 = sub nsw i32 %71, 1
  store i32 %72, ptr %8, align 4, !tbaa !9
  br label %73

73:                                               ; preds = %49, %45
  br label %74

74:                                               ; preds = %73
  %75 = load i32, ptr %7, align 4, !tbaa !9
  %76 = load i32, ptr %8, align 4, !tbaa !9
  %77 = icmp sle i32 %75, %76
  br i1 %77, label %21, label %78, !llvm.loop !18

78:                                               ; preds = %74
  %79 = load i32, ptr %5, align 4, !tbaa !9
  %80 = load i32, ptr %8, align 4, !tbaa !9
  %81 = icmp slt i32 %79, %80
  br i1 %81, label %82, label %86

82:                                               ; preds = %78
  %83 = load ptr, ptr %4, align 8, !tbaa !14
  %84 = load i32, ptr %5, align 4, !tbaa !9
  %85 = load i32, ptr %8, align 4, !tbaa !9
  call void @Quicksort(ptr noundef %83, i32 noundef %84, i32 noundef %85)
  br label %86

86:                                               ; preds = %82, %78
  %87 = load i32, ptr %7, align 4, !tbaa !9
  %88 = load i32, ptr %6, align 4, !tbaa !9
  %89 = icmp slt i32 %87, %88
  br i1 %89, label %90, label %94

90:                                               ; preds = %86
  %91 = load ptr, ptr %4, align 8, !tbaa !14
  %92 = load i32, ptr %7, align 4, !tbaa !9
  %93 = load i32, ptr %6, align 4, !tbaa !9
  call void @Quicksort(ptr noundef %91, i32 noundef %92, i32 noundef %93)
  br label %94

94:                                               ; preds = %90, %86
  call void @llvm.lifetime.end.p0(i64 4, ptr %10) #2
  call void @llvm.lifetime.end.p0(i64 4, ptr %9) #2
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #2
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #2
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Quick() #0 {
  %1 = alloca i32, align 4
  call void @Initarr()
  call void @Quicksort(ptr noundef @sortlist, i32 noundef 1, i32 noundef 5000)
  %2 = load i32, ptr getelementptr inbounds ([5001 x i32], ptr @sortlist, i64 0, i64 1), align 4, !tbaa !9
  %3 = load i32, ptr @littlest, align 4, !tbaa !9
  %4 = icmp ne i32 %2, %3
  br i1 %4, label %9, label %5

5:                                                ; preds = %0
  %6 = load i32, ptr getelementptr inbounds ([5001 x i32], ptr @sortlist, i64 0, i64 5000), align 16, !tbaa !9
  %7 = load i32, ptr @biggest, align 4, !tbaa !9
  %8 = icmp ne i32 %6, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %5, %0
  store i32 -42, ptr %1, align 4
  br label %12

10:                                               ; preds = %5
  %11 = load i32, ptr getelementptr inbounds ([5001 x i32], ptr @sortlist, i64 0, i64 5000), align 16, !tbaa !9
  store i32 %11, ptr %1, align 4
  br label %12

12:                                               ; preds = %10, %9
  %13 = load i32, ptr %1, align 4
  ret i32 %13
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind }

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
!16 = distinct !{!16, !12, !13}
!17 = distinct !{!17, !12, !13}
!18 = distinct !{!18, !12, !13}
