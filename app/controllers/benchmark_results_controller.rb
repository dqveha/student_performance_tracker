class BenchmarkResultsController < ApplicationController
  def index
    @student = Student.find(params[:student_id])
    @benchmark_results = @student.benchmark_results

    render :index
  end

  def new
    @student = Student.find(params[:student_id])
    @benchmark_result = @student.benchmark_results.new
    render :new
  end

  def create
    @student = Student.find(params[:student_id])
    @benchmark_result = @student.benchmark_results.new(benchmark_result_params)
    if @benchmark_result.save
      flash[:notice] = "Benchmark score successfully added!"
      redirect_to student_path(@student)
    else
      render :new
    end
  end

  def show
    @student = Student.find(params[:student_id])
    @benchmark_result = Benchmark.find(params[:id])
    render :show
  end

  def edit
    @student = Student.find(params[:student_id])
    @benchmark_result = Benchmark.find(params[:id])
    render :edit
  end

  def update
    @benchmark_result = Benchmark.find(params[:id])
    if @benchmark_result.update(benchmark_result_params)
      flash[:notice] = "Benchmark score successfully updated!"
      redirect_to student_benchmark_results_path(@benchmark_result.student)
    else
      @student = Student.find(params[:student_id])
      render :edit
    end
  end

  def destroy
    @benchmark_result = Benchmark.find(params[:id])
    @benchmark_result.destroy
    flash[:notice] = "Benchmark score successfully deleted!"
    redirect_to student_path(@benchmark_result.student)
  end

  private

  def benchmark_result_params
    params.require(:benchmark_result).permit(:date, :ge, :vocab_ge, :reading_comp_ge, :lnf, :snf, :orf_grade_lvl, :orf_cwpm, :orf_accuracy)
  end
end