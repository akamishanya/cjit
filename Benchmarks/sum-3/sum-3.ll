; ModuleID = 'sum-3.c'
source_filename = "sum-3.c"

@seed = internal global i64 0, align 8
@size1 = internal global i32 0, align 4
@size2 = internal global i32 0, align 4
@size3 = internal global i32 0, align 4
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
  store i32 %4, ptr @size1, align 4, !tbaa !11
  %5 = load i32, ptr %3, align 4, !tbaa !11
  store i32 %5, ptr @size2, align 4, !tbaa !11
  %6 = load i32, ptr %3, align 4, !tbaa !11
  store i32 %6, ptr @size3, align 4, !tbaa !11
  %7 = load i32, ptr %3, align 4, !tbaa !11
  %8 = sext i32 %7 to i64
  %9 = call ptr @calloc(i64 noundef %8, i64 noundef 4) #6
  store ptr %9, ptr @ima, align 8, !tbaa !9
  %10 = load ptr, ptr @ima, align 8, !tbaa !9
  %11 = icmp ne ptr %10, null
  br i1 %11, label %13, label %12

12:                                               ; preds = %1
  store i32 0, ptr %2, align 4
  br label %35

13:                                               ; preds = %1
  %14 = load i32, ptr %3, align 4, !tbaa !11
  %15 = sext i32 %14 to i64
  %16 = call ptr @calloc(i64 noundef %15, i64 noundef 4) #6
  store ptr %16, ptr @imb, align 8, !tbaa !9
  %17 = load ptr, ptr @imb, align 8, !tbaa !9
  %18 = icmp ne ptr %17, null
  br i1 %18, label %21, label %19

19:                                               ; preds = %13
  %20 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %20)
  store i32 0, ptr %2, align 4
  br label %35

21:                                               ; preds = %13
  %22 = load i32, ptr %3, align 4, !tbaa !11
  %23 = sext i32 %22 to i64
  %24 = call ptr @calloc(i64 noundef %23, i64 noundef 4) #6
  store ptr %24, ptr @imr, align 8, !tbaa !9
  %25 = load ptr, ptr @imr, align 8, !tbaa !9
  %26 = icmp ne ptr %25, null
  br i1 %26, label %30, label %27

27:                                               ; preds = %21
  %28 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %28)
  %29 = load ptr, ptr @imb, align 8, !tbaa !9
  call void @free(ptr noundef %29)
  store i32 0, ptr %2, align 4
  br label %35

30:                                               ; preds = %21
  call void @Initrand()
  %31 = load ptr, ptr @ima, align 8, !tbaa !9
  %32 = load i32, ptr @size1, align 4, !tbaa !11
  call void @InitArray(ptr noundef %31, i32 noundef %32)
  %33 = load ptr, ptr @imb, align 8, !tbaa !9
  %34 = load i32, ptr @size2, align 4, !tbaa !11
  call void @InitArray(ptr noundef %33, i32 noundef %34)
  store i32 1, ptr %2, align 4
  br label %35

35:                                               ; preds = %30, %27, %19, %12
  %36 = load i32, ptr %2, align 4
  ret i32 %36
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
define dso_local i32 @sum_3() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %1) #5
  %10 = load i32, ptr @size1, align 4, !tbaa !11
  store i32 %10, ptr %1, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %2) #5
  %11 = load i32, ptr @size2, align 4, !tbaa !11
  store i32 %11, ptr %2, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #5
  %12 = load i32, ptr @size3, align 4, !tbaa !11
  store i32 %12, ptr %3, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #5
  store i32 0, ptr %4, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #5
  store i32 0, ptr %5, align 4, !tbaa !11
  br label %13

13:                                               ; preds = %89, %0
  %14 = load i32, ptr %5, align 4, !tbaa !11
  %15 = load i32, ptr %1, align 4, !tbaa !11
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %18, label %17

17:                                               ; preds = %13
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #5
  br label %92

18:                                               ; preds = %13
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #5
  %19 = load ptr, ptr @ima, align 8, !tbaa !9
  %20 = icmp ne ptr %19, null
  br i1 %20, label %21, label %28

21:                                               ; preds = %18
  %22 = load i32, ptr %5, align 4, !tbaa !11
  %23 = icmp slt i32 %22, 0
  br i1 %23, label %28, label %24

24:                                               ; preds = %21
  %25 = load i32, ptr %5, align 4, !tbaa !11
  %26 = load i32, ptr %1, align 4, !tbaa !11
  %27 = icmp sge i32 %25, %26
  br i1 %27, label %28, label %29

28:                                               ; preds = %24, %21, %18
  call void @abort() #7
  unreachable

29:                                               ; preds = %24
  %30 = load ptr, ptr @ima, align 8, !tbaa !9
  %31 = load i32, ptr %5, align 4, !tbaa !11
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds i32, ptr %30, i64 %32
  %34 = load i32, ptr %33, align 4, !tbaa !11
  store i32 %34, ptr %6, align 4, !tbaa !11
  %35 = load ptr, ptr @imb, align 8, !tbaa !9
  %36 = icmp ne ptr %35, null
  br i1 %36, label %37, label %44

37:                                               ; preds = %29
  %38 = load i32, ptr %5, align 4, !tbaa !11
  %39 = icmp slt i32 %38, 0
  br i1 %39, label %44, label %40

40:                                               ; preds = %37
  %41 = load i32, ptr %5, align 4, !tbaa !11
  %42 = load i32, ptr %2, align 4, !tbaa !11
  %43 = icmp sge i32 %41, %42
  br i1 %43, label %44, label %45

44:                                               ; preds = %40, %37, %29
  call void @abort() #7
  unreachable

45:                                               ; preds = %40
  %46 = load ptr, ptr @imb, align 8, !tbaa !9
  %47 = load i32, ptr %5, align 4, !tbaa !11
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds i32, ptr %46, i64 %48
  %50 = load i32, ptr %49, align 4, !tbaa !11
  store i32 %50, ptr %7, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #5
  %51 = load i32, ptr %6, align 4, !tbaa !11
  %52 = load i32, ptr %7, align 4, !tbaa !11
  %53 = add nsw i32 %51, %52
  store i32 %53, ptr %8, align 4, !tbaa !11
  %54 = load ptr, ptr @imr, align 8, !tbaa !9
  %55 = icmp ne ptr %54, null
  br i1 %55, label %56, label %63

56:                                               ; preds = %45
  %57 = load i32, ptr %5, align 4, !tbaa !11
  %58 = icmp slt i32 %57, 0
  br i1 %58, label %63, label %59

59:                                               ; preds = %56
  %60 = load i32, ptr %5, align 4, !tbaa !11
  %61 = load i32, ptr %3, align 4, !tbaa !11
  %62 = icmp sge i32 %60, %61
  br i1 %62, label %63, label %64

63:                                               ; preds = %59, %56, %45
  call void @abort() #7
  unreachable

64:                                               ; preds = %59
  %65 = load i32, ptr %8, align 4, !tbaa !11
  %66 = load ptr, ptr @imr, align 8, !tbaa !9
  %67 = load i32, ptr %5, align 4, !tbaa !11
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds i32, ptr %66, i64 %68
  store i32 %65, ptr %69, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %9) #5
  %70 = load ptr, ptr @imr, align 8, !tbaa !9
  %71 = icmp ne ptr %70, null
  br i1 %71, label %72, label %79

72:                                               ; preds = %64
  %73 = load i32, ptr %5, align 4, !tbaa !11
  %74 = icmp slt i32 %73, 0
  br i1 %74, label %79, label %75

75:                                               ; preds = %72
  %76 = load i32, ptr %5, align 4, !tbaa !11
  %77 = load i32, ptr %3, align 4, !tbaa !11
  %78 = icmp sge i32 %76, %77
  br i1 %78, label %79, label %80

79:                                               ; preds = %75, %72, %64
  call void @abort() #7
  unreachable

80:                                               ; preds = %75
  %81 = load ptr, ptr @imr, align 8, !tbaa !9
  %82 = load i32, ptr %5, align 4, !tbaa !11
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds i32, ptr %81, i64 %83
  %85 = load i32, ptr %84, align 4, !tbaa !11
  store i32 %85, ptr %9, align 4, !tbaa !11
  %86 = load i32, ptr %9, align 4, !tbaa !11
  %87 = load i32, ptr %4, align 4, !tbaa !11
  %88 = add i32 %87, %86
  store i32 %88, ptr %4, align 4, !tbaa !11
  call void @llvm.lifetime.end.p0(i64 4, ptr %9) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #5
  br label %89

89:                                               ; preds = %80
  %90 = load i32, ptr %5, align 4, !tbaa !11
  %91 = add nsw i32 %90, 1
  store i32 %91, ptr %5, align 4, !tbaa !11
  br label %13, !llvm.loop !16

92:                                               ; preds = %17
  %93 = load i32, ptr %4, align 4, !tbaa !11
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %2) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %1) #5
  ret i32 %93
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
