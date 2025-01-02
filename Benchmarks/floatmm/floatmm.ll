; ModuleID = 'floatmm.c'
source_filename = "floatmm.c"

@rowsize = internal global i32 0, align 4
@rma = internal global ptr null, align 8
@rmb = internal global ptr null, align 8
@rmr = internal global ptr null, align 8
@seed = internal global i64 0, align 8

; Function Attrs: nounwind uwtable
define dso_local i32 @init(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store i32 %0, ptr %3, align 4, !tbaa !5
  %9 = load i32, ptr %3, align 4, !tbaa !5
  store i32 %9, ptr @rowsize, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %4) #5
  %10 = load i32, ptr %3, align 4, !tbaa !5
  %11 = add nsw i32 %10, 1
  %12 = sext i32 %11 to i64
  %13 = mul i64 4, %12
  %14 = load i32, ptr %3, align 4, !tbaa !5
  %15 = add nsw i32 %14, 1
  %16 = sext i32 %15 to i64
  %17 = mul i64 %13, %16
  %18 = call ptr @malloc(i64 noundef %17) #6
  store ptr %18, ptr %4, align 8, !tbaa !9
  %19 = load ptr, ptr %4, align 8, !tbaa !9
  %20 = icmp ne ptr %19, null
  br i1 %20, label %22, label %21

21:                                               ; preds = %1
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %139

22:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #5
  %23 = load i32, ptr %3, align 4, !tbaa !5
  %24 = add nsw i32 %23, 1
  %25 = sext i32 %24 to i64
  %26 = mul i64 4, %25
  %27 = load i32, ptr %3, align 4, !tbaa !5
  %28 = add nsw i32 %27, 1
  %29 = sext i32 %28 to i64
  %30 = mul i64 %26, %29
  %31 = call ptr @malloc(i64 noundef %30) #6
  store ptr %31, ptr %6, align 8, !tbaa !9
  %32 = load ptr, ptr %6, align 8, !tbaa !9
  %33 = icmp ne ptr %32, null
  br i1 %33, label %36, label %34

34:                                               ; preds = %22
  %35 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %35)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %138

36:                                               ; preds = %22
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #5
  %37 = load i32, ptr %3, align 4, !tbaa !5
  %38 = add nsw i32 %37, 1
  %39 = sext i32 %38 to i64
  %40 = mul i64 4, %39
  %41 = load i32, ptr %3, align 4, !tbaa !5
  %42 = add nsw i32 %41, 1
  %43 = sext i32 %42 to i64
  %44 = mul i64 %40, %43
  %45 = call ptr @malloc(i64 noundef %44) #6
  store ptr %45, ptr %7, align 8, !tbaa !9
  %46 = load ptr, ptr %7, align 8, !tbaa !9
  %47 = icmp ne ptr %46, null
  br i1 %47, label %51, label %48

48:                                               ; preds = %36
  %49 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %49)
  %50 = load ptr, ptr %6, align 8, !tbaa !9
  call void @free(ptr noundef %50)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %137

51:                                               ; preds = %36
  %52 = load i32, ptr %3, align 4, !tbaa !5
  %53 = add nsw i32 %52, 1
  %54 = sext i32 %53 to i64
  %55 = mul i64 8, %54
  %56 = call ptr @malloc(i64 noundef %55) #6
  store ptr %56, ptr @rma, align 8, !tbaa !9
  %57 = load ptr, ptr @rma, align 8, !tbaa !9
  %58 = icmp ne ptr %57, null
  br i1 %58, label %63, label %59

59:                                               ; preds = %51
  %60 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %60)
  %61 = load ptr, ptr %6, align 8, !tbaa !9
  call void @free(ptr noundef %61)
  %62 = load ptr, ptr %7, align 8, !tbaa !9
  call void @free(ptr noundef %62)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %137

63:                                               ; preds = %51
  %64 = load i32, ptr %3, align 4, !tbaa !5
  %65 = add nsw i32 %64, 1
  %66 = sext i32 %65 to i64
  %67 = mul i64 8, %66
  %68 = call ptr @malloc(i64 noundef %67) #6
  store ptr %68, ptr @rmb, align 8, !tbaa !9
  %69 = load ptr, ptr @rmb, align 8, !tbaa !9
  %70 = icmp ne ptr %69, null
  br i1 %70, label %76, label %71

71:                                               ; preds = %63
  %72 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %72)
  %73 = load ptr, ptr %6, align 8, !tbaa !9
  call void @free(ptr noundef %73)
  %74 = load ptr, ptr %7, align 8, !tbaa !9
  call void @free(ptr noundef %74)
  %75 = load ptr, ptr @rma, align 8, !tbaa !9
  call void @free(ptr noundef %75)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %137

76:                                               ; preds = %63
  %77 = load i32, ptr %3, align 4, !tbaa !5
  %78 = add nsw i32 %77, 1
  %79 = sext i32 %78 to i64
  %80 = mul i64 8, %79
  %81 = call ptr @malloc(i64 noundef %80) #6
  store ptr %81, ptr @rmr, align 8, !tbaa !9
  %82 = load ptr, ptr @rmr, align 8, !tbaa !9
  %83 = icmp ne ptr %82, null
  br i1 %83, label %90, label %84

84:                                               ; preds = %76
  %85 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %85)
  %86 = load ptr, ptr %6, align 8, !tbaa !9
  call void @free(ptr noundef %86)
  %87 = load ptr, ptr %7, align 8, !tbaa !9
  call void @free(ptr noundef %87)
  %88 = load ptr, ptr @rma, align 8, !tbaa !9
  call void @free(ptr noundef %88)
  %89 = load ptr, ptr @rmb, align 8, !tbaa !9
  call void @free(ptr noundef %89)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %137

90:                                               ; preds = %76
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #5
  store i32 0, ptr %8, align 4, !tbaa !5
  br label %91

91:                                               ; preds = %131, %90
  %92 = load i32, ptr %8, align 4, !tbaa !5
  %93 = load i32, ptr %3, align 4, !tbaa !5
  %94 = add nsw i32 %93, 1
  %95 = icmp slt i32 %92, %94
  br i1 %95, label %97, label %96

96:                                               ; preds = %91
  store i32 2, ptr %5, align 4
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #5
  br label %134

97:                                               ; preds = %91
  %98 = load ptr, ptr %4, align 8, !tbaa !9
  %99 = load i32, ptr %8, align 4, !tbaa !5
  %100 = load i32, ptr %3, align 4, !tbaa !5
  %101 = add nsw i32 %100, 1
  %102 = mul nsw i32 %99, %101
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds float, ptr %98, i64 %103
  %105 = load ptr, ptr @rma, align 8, !tbaa !9
  %106 = load i32, ptr %8, align 4, !tbaa !5
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds ptr, ptr %105, i64 %107
  store ptr %104, ptr %108, align 8, !tbaa !9
  %109 = load ptr, ptr %6, align 8, !tbaa !9
  %110 = load i32, ptr %8, align 4, !tbaa !5
  %111 = load i32, ptr %3, align 4, !tbaa !5
  %112 = add nsw i32 %111, 1
  %113 = mul nsw i32 %110, %112
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds float, ptr %109, i64 %114
  %116 = load ptr, ptr @rmb, align 8, !tbaa !9
  %117 = load i32, ptr %8, align 4, !tbaa !5
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds ptr, ptr %116, i64 %118
  store ptr %115, ptr %119, align 8, !tbaa !9
  %120 = load ptr, ptr %7, align 8, !tbaa !9
  %121 = load i32, ptr %8, align 4, !tbaa !5
  %122 = load i32, ptr %3, align 4, !tbaa !5
  %123 = add nsw i32 %122, 1
  %124 = mul nsw i32 %121, %123
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds float, ptr %120, i64 %125
  %127 = load ptr, ptr @rmr, align 8, !tbaa !9
  %128 = load i32, ptr %8, align 4, !tbaa !5
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds ptr, ptr %127, i64 %129
  store ptr %126, ptr %130, align 8, !tbaa !9
  br label %131

131:                                              ; preds = %97
  %132 = load i32, ptr %8, align 4, !tbaa !5
  %133 = add nsw i32 %132, 1
  store i32 %133, ptr %8, align 4, !tbaa !5
  br label %91, !llvm.loop !11

134:                                              ; preds = %96
  call void @Initrand()
  %135 = load ptr, ptr @rma, align 8, !tbaa !9
  call void @rInitmatrix(ptr noundef %135)
  %136 = load ptr, ptr @rmb, align 8, !tbaa !9
  call void @rInitmatrix(ptr noundef %136)
  store i32 1, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %137

137:                                              ; preds = %134, %84, %71, %59, %48
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #5
  br label %138

138:                                              ; preds = %137, %34
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #5
  br label %139

139:                                              ; preds = %138, %21
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #5
  %140 = load i32, ptr %2, align 4
  ret i32 %140
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #2

declare void @free(ptr noundef) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define internal void @rInitmatrix(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #5
  store i32 1, ptr %4, align 4, !tbaa !5
  br label %6

6:                                                ; preds = %37, %1
  %7 = load i32, ptr %4, align 4, !tbaa !5
  %8 = load i32, ptr @rowsize, align 4, !tbaa !5
  %9 = icmp sle i32 %7, %8
  br i1 %9, label %10, label %40

10:                                               ; preds = %6
  store i32 1, ptr %5, align 4, !tbaa !5
  br label %11

11:                                               ; preds = %33, %10
  %12 = load i32, ptr %5, align 4, !tbaa !5
  %13 = load i32, ptr @rowsize, align 4, !tbaa !5
  %14 = icmp sle i32 %12, %13
  br i1 %14, label %15, label %36

15:                                               ; preds = %11
  %16 = call i32 @Rand()
  store i32 %16, ptr %3, align 4, !tbaa !5
  %17 = load i32, ptr %3, align 4, !tbaa !5
  %18 = load i32, ptr %3, align 4, !tbaa !5
  %19 = sdiv i32 %18, 120
  %20 = mul nsw i32 %19, 120
  %21 = sub nsw i32 %17, %20
  %22 = sub nsw i32 %21, 60
  %23 = sitofp i32 %22 to float
  %24 = fdiv float %23, 3.000000e+00
  %25 = load ptr, ptr %2, align 8, !tbaa !9
  %26 = load i32, ptr %4, align 4, !tbaa !5
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds ptr, ptr %25, i64 %27
  %29 = load ptr, ptr %28, align 8, !tbaa !9
  %30 = load i32, ptr %5, align 4, !tbaa !5
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds float, ptr %29, i64 %31
  store float %24, ptr %32, align 4, !tbaa !14
  br label %33

33:                                               ; preds = %15
  %34 = load i32, ptr %5, align 4, !tbaa !5
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %5, align 4, !tbaa !5
  br label %11, !llvm.loop !16

36:                                               ; preds = %11
  br label %37

37:                                               ; preds = %36
  %38 = load i32, ptr %4, align 4, !tbaa !5
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %4, align 4, !tbaa !5
  br label %6, !llvm.loop !17

40:                                               ; preds = %6
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #5
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @deinit() #0 {
  %1 = load ptr, ptr @rma, align 8, !tbaa !9
  %2 = getelementptr inbounds ptr, ptr %1, i64 0
  %3 = load ptr, ptr %2, align 8, !tbaa !9
  call void @free(ptr noundef %3)
  %4 = load ptr, ptr @rmb, align 8, !tbaa !9
  %5 = getelementptr inbounds ptr, ptr %4, i64 0
  %6 = load ptr, ptr %5, align 8, !tbaa !9
  call void @free(ptr noundef %6)
  %7 = load ptr, ptr @rmr, align 8, !tbaa !9
  %8 = getelementptr inbounds ptr, ptr %7, i64 0
  %9 = load ptr, ptr %8, align 8, !tbaa !9
  call void @free(ptr noundef %9)
  %10 = load ptr, ptr @rma, align 8, !tbaa !9
  call void @free(ptr noundef %10)
  %11 = load ptr, ptr @rmb, align 8, !tbaa !9
  call void @free(ptr noundef %11)
  %12 = load ptr, ptr @rmr, align 8, !tbaa !9
  call void @free(ptr noundef %12)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local double @floatmm() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %1) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %2) #5
  store i32 1, ptr %1, align 4, !tbaa !5
  br label %3

3:                                                ; preds = %29, %0
  %4 = load i32, ptr %1, align 4, !tbaa !5
  %5 = load i32, ptr @rowsize, align 4, !tbaa !5
  %6 = icmp sle i32 %4, %5
  br i1 %6, label %7, label %32

7:                                                ; preds = %3
  store i32 1, ptr %2, align 4, !tbaa !5
  br label %8

8:                                                ; preds = %25, %7
  %9 = load i32, ptr %2, align 4, !tbaa !5
  %10 = load i32, ptr @rowsize, align 4, !tbaa !5
  %11 = icmp sle i32 %9, %10
  br i1 %11, label %12, label %28

12:                                               ; preds = %8
  %13 = load ptr, ptr @rmr, align 8, !tbaa !9
  %14 = load i32, ptr %1, align 4, !tbaa !5
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds ptr, ptr %13, i64 %15
  %17 = load ptr, ptr %16, align 8, !tbaa !9
  %18 = load i32, ptr %2, align 4, !tbaa !5
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds float, ptr %17, i64 %19
  %21 = load ptr, ptr @rma, align 8, !tbaa !9
  %22 = load ptr, ptr @rmb, align 8, !tbaa !9
  %23 = load i32, ptr %1, align 4, !tbaa !5
  %24 = load i32, ptr %2, align 4, !tbaa !5
  call void @rInnerproduct(ptr noundef %20, ptr noundef %21, ptr noundef %22, i32 noundef %23, i32 noundef %24)
  br label %25

25:                                               ; preds = %12
  %26 = load i32, ptr %2, align 4, !tbaa !5
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %2, align 4, !tbaa !5
  br label %8, !llvm.loop !18

28:                                               ; preds = %8
  br label %29

29:                                               ; preds = %28
  %30 = load i32, ptr %1, align 4, !tbaa !5
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %1, align 4, !tbaa !5
  br label %3, !llvm.loop !19

32:                                               ; preds = %3
  %33 = load ptr, ptr @rmr, align 8, !tbaa !9
  %34 = getelementptr inbounds ptr, ptr %33, i64 1
  %35 = load ptr, ptr %34, align 8, !tbaa !9
  %36 = getelementptr inbounds float, ptr %35, i64 1
  %37 = load float, ptr %36, align 4, !tbaa !14
  %38 = fpext float %37 to double
  call void @llvm.lifetime.end.p0(i64 4, ptr %2) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %1) #5
  ret double %38
}

; Function Attrs: nounwind uwtable
define internal void @rInnerproduct(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %6, align 8, !tbaa !9
  store ptr %1, ptr %7, align 8, !tbaa !9
  store ptr %2, ptr %8, align 8, !tbaa !9
  store i32 %3, ptr %9, align 4, !tbaa !5
  store i32 %4, ptr %10, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 4, ptr %11) #5
  %12 = load ptr, ptr %6, align 8, !tbaa !9
  store float 0.000000e+00, ptr %12, align 4, !tbaa !14
  store i32 1, ptr %11, align 4, !tbaa !5
  br label %13

13:                                               ; preds = %40, %5
  %14 = load i32, ptr %11, align 4, !tbaa !5
  %15 = load i32, ptr @rowsize, align 4, !tbaa !5
  %16 = icmp sle i32 %14, %15
  br i1 %16, label %17, label %43

17:                                               ; preds = %13
  %18 = load ptr, ptr %6, align 8, !tbaa !9
  %19 = load float, ptr %18, align 4, !tbaa !14
  %20 = load ptr, ptr %7, align 8, !tbaa !9
  %21 = load i32, ptr %9, align 4, !tbaa !5
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds ptr, ptr %20, i64 %22
  %24 = load ptr, ptr %23, align 8, !tbaa !9
  %25 = load i32, ptr %11, align 4, !tbaa !5
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds float, ptr %24, i64 %26
  %28 = load float, ptr %27, align 4, !tbaa !14
  %29 = load ptr, ptr %8, align 8, !tbaa !9
  %30 = load i32, ptr %11, align 4, !tbaa !5
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds ptr, ptr %29, i64 %31
  %33 = load ptr, ptr %32, align 8, !tbaa !9
  %34 = load i32, ptr %10, align 4, !tbaa !5
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds float, ptr %33, i64 %35
  %37 = load float, ptr %36, align 4, !tbaa !14
  %38 = call float @llvm.fmuladd.f32(float %28, float %37, float %19)
  %39 = load ptr, ptr %6, align 8, !tbaa !9
  store float %38, ptr %39, align 4, !tbaa !14
  br label %40

40:                                               ; preds = %17
  %41 = load i32, ptr %11, align 4, !tbaa !5
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %11, align 4, !tbaa !5
  br label %13, !llvm.loop !20

43:                                               ; preds = %13
  call void @llvm.lifetime.end.p0(i64 4, ptr %11) #5
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @Initrand() #0 {
  store i64 74755, ptr @seed, align 8, !tbaa !21
  ret void
}

; Function Attrs: nounwind uwtable
define internal i32 @Rand() #0 {
  %1 = load i64, ptr @seed, align 8, !tbaa !21
  %2 = mul nsw i64 %1, 1309
  %3 = add nsw i64 %2, 13849
  %4 = and i64 %3, 65535
  store i64 %4, ptr @seed, align 8, !tbaa !21
  %5 = load i64, ptr @seed, align 8, !tbaa !21
  %6 = trunc i64 %5 to i32
  ret i32 %6
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind }
attributes #6 = { allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 19.1.2 (++20241028122730+d8752671e825-1~exp1~20241028122742.57)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !7, i64 0}
!11 = distinct !{!11, !12, !13}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!"llvm.loop.unroll.disable"}
!14 = !{!15, !15, i64 0}
!15 = !{!"float", !7, i64 0}
!16 = distinct !{!16, !12, !13}
!17 = distinct !{!17, !12, !13}
!18 = distinct !{!18, !12, !13}
!19 = distinct !{!19, !12, !13}
!20 = distinct !{!20, !12, !13}
!21 = !{!22, !22, i64 0}
!22 = !{!"long", !7, i64 0}
