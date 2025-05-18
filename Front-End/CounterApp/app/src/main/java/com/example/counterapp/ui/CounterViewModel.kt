package com.example.counterapp

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class CounterViewModel: ViewModel() {
    private val counter = Counter()
    private val _count = MutableLiveData<Int>()

    init {
        _count.value = counter.count
    }
    fun increment() {
        counter.count++
        _count.value = counter.count
    }
    fun decrement() {
        counter.count--
        _count.value = counter.count
    }
}